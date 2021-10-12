%--------------------------------------------------------------------------
%fft_enhance_cubs
%enhances the fingerprint image
%syntax:
%[oimg,fimg,bwimg,eimg,enhimg] =  fft_enhance_cubs(img)
%oimg -  [OUT] block orientation image(can be viewed using
%        view_orientation_image.m)
%fimg  - [OUT] block frequency image(indicates ridge spacing)
%bwimg - [OUT] shows angular bandwidth image(filter bandwidth adapts near the
%        singular points)
%eimg  - [OUT] energy image. Indicates the 'ridgeness' of a block (can be 
%        used for fingerprint segmentation)
%enhimg- [OUT] enhanced image
%img   - [IN]  input fingerprint image (HAS to be of DOUBLE type)
%Contact:
%   ssc5@cubs.buffalo.edu sharat@mit.edu
%   http://www.sharat.org
%Reference:
%1. S. Chikkerur, C.Wu and V. Govindaraju, "Systematic approach for feature
%   extraction in Fingerprint Images", ICBA 2004
%2. S. Chikkerur and V. Govindaraju, "Fingerprint Image Enhancement using 
%   STFT Analysis", International Workshop on Pattern Recognition for Crime 
%   Prevention, Security and Surveillance, ICAPR 2005
%3. S. Chikkeur, "Online Fingerprint Verification", M. S. Thesis,
%   University at Buffalo, 2005
%4. T. Jea and V. Govindaraju, "A Minutia-Based Partial Fingerprint Recognition System", 
%   to appear in Pattern Recognition 2005
%5. S. Chikkerur, "K-plet and CBFS: A Graph based Fingerprint
%   Representation and Matching Algorithm", submitted, ICB 2006
% See also: cubs_visualize_template
%--------------------------------------------------------------------------
function [oimg,fimg,bwimg,eimg,enhimg] =  fft_enhance_cubs(img)
    global NFFT;
    NFFT            =   32;     %size of FFT
    BLKSZ           =   12;      %size of the block
    OVRLP           =   6;      %size of overlap
    ALPHA           =   0.4;    %root filtering
    RMIN            =   5;      %min allowable ridge spacing
    RMAX            =   20;     %maximum allowable ridge spacing
    do_prefiltering =   1;
    [nHt,nWt]       =   size(img);  
    img             =   im2double(img);    %convert to DOUBLE
    
    nBlkHt          =   floor((nHt-2*OVRLP)/BLKSZ);
    nBlkWt          =   floor((nWt-2*OVRLP)/BLKSZ);
    fftSrc          =   zeros(nBlkHt*nBlkWt,NFFT*NFFT); %stores FFT
    nWndSz          =   BLKSZ+2*OVRLP; %size of analysis window. 
    warning off MATLAB:divideByZero
    %-------------------------
    %allocate outputs
    %-------------------------
    oimg        =   zeros(nBlkHt,nBlkWt);
    fimg        =   zeros(nBlkHt,nBlkWt);
    bwimg       =   zeros(nBlkHt,nBlkWt);
    eimg        =   zeros(nBlkHt,nBlkWt);
    enhimg      =   zeros(nHt,nWt);
    
    %-------------------------
    %precomputations
    %-------------------------
    [x,y]       =   meshgrid(0:nWndSz-1,0:nWndSz-1);
    dMult       =   (-1).^(x+y); %used to center the FFT
    [x,y]       =   meshgrid(-NFFT/2:NFFT/2-1,-NFFT/2:NFFT/2-1);
    r           =   sqrt(x.^2+y.^2)+eps;
    th          =   atan2(y,x);
    th(th<0)    =   th(th<0)+pi;
    w           =   raised_cosine_window(BLKSZ,OVRLP); %spectral window
    
    %-------------------------
    %FFT Analysis
    %-------------------------
    for i = 0:nBlkHt-1
        nRow = i*BLKSZ+OVRLP+1;  
        for j = 0:nBlkWt-1
            nCol = j*BLKSZ+OVRLP+1;
            %extract local block
            blk     =   img(nRow-OVRLP:nRow+BLKSZ+OVRLP-1,nCol-OVRLP:nCol+BLKSZ+OVRLP-1);
            %remove dc
            dAvg    =   sum(sum(blk))/(nWndSz*nWndSz);
            blk     =   blk-dAvg;   %remove DC content
            blk     =   blk.*w;     %multiply by spectral window
            %--------------------------
            %do pre filtering
            %--------------------------
            blkfft  =   fft2(blk.*dMult,NFFT,NFFT);
            if(do_prefiltering)
                dEnergy =   abs(blkfft).^2;
                blkfft  =   blkfft.*sqrt(dEnergy);      %root filtering(for diffusion)
            end;
            fftSrc(nBlkWt*i+j+1,:) = transpose(blkfft(:));
            dEnergy =   abs(blkfft).^2;             %----REDUCE THIS COMPUTATION----
            %--------------------------
            %compute statistics
            %--------------------------
            dTotal          =   sum(sum(dEnergy));%/(NFFT*NFFT);
            fimg(i+1,j+1)   =   NFFT/(compute_mean_frequency(dEnergy,r)+eps); %ridge separation
            oimg(i+1,j+1)   =   compute_mean_angle(dEnergy,th);         %ridge angle
            eimg(i+1,j+1)   =   log(dTotal+eps);                        %used for segmentation
        end;%for j
    end;%for i

    %-------------------------
    %precomputations
    %-------------------------
    [x,y]       =   meshgrid(-NFFT/2:NFFT/2-1,-NFFT/2:NFFT/2-1);
    dMult       =   (-1).^(x+y); %used to center the FFT

    %-------------------------
    %process the resulting maps
    %-------------------------
    for i = 1:3
        oimg = smoothen_orientation_image(oimg);            %smoothen orientation image
    end;
    fimg    =   smoothen_frequency_image(fimg,RMIN,RMAX,5); %diffuse frequency image
    imshow(fimg,[]);
    cimg    =   compute_coherence(oimg);       %coherence image for bandwidth
    imshow(cimg,[]);
    bwimg   =   get_angular_bw_image(cimg);                 %QUANTIZED bandwidth image
    imshow(bwimg,[]);
    %-------------------------
    %FFT reconstruction
    %-------------------------
    for i = 0:nBlkHt-1
        for j = 0:nBlkWt-1
            nRow = i*BLKSZ+OVRLP+1;            
            nCol = j*BLKSZ+OVRLP+1;
            %--------------------------
            %apply the filters
            %--------------------------
            blkfft  =   reshape(transpose(fftSrc(nBlkWt*i+j+1,:)),NFFT,NFFT);
            %--------------------------
            %reconstruction
            %--------------------------
            af      =   get_angular_filter(oimg(i+1,j+1),bwimg(i+1,j+1));
            rf      =   get_radial_filter(fimg(i+1,j+1));
            blkfft  =   blkfft.*(af).*(rf); 
            blk     =   real(ifft2(blkfft).*dMult);
            enhimg(nRow:nRow+BLKSZ-1,nCol:nCol+BLKSZ-1)=blk(OVRLP+1:OVRLP+BLKSZ,OVRLP+1:OVRLP+BLKSZ);
        end;%for j
    end;%for i
    %end block processing
    %--------------------------
    %contrast enhancement
    %--------------------------
    enhimg =sqrt(abs(enhimg)).*sign(enhimg);
    enhimg =imscale(enhimg);
    
    enhimg =im2uint8(enhimg);
    
    %--------------------------
    %clean up the image
    %--------------------------
    emsk            = segment_print(enhimg,0);
    enhimg(emsk==0) = 128;
%end function fft_enhance_cubs

%-----------------------------------
%raised_cosine
%returns 1D spectral window
%syntax:
%y = raised_cosine(nBlkSz,nOvrlp)
%y      - [OUT] 1D raised cosine function
%nBlkSz - [IN]  the window is constant here
%nOvrlp - [IN]  the window has transition here
%-----------------------------------
function y = raised_cosine(nBlkSz,nOvrlp)
    nWndSz  =   (nBlkSz+2*nOvrlp);
    x       =   abs(-nWndSz/2:nWndSz/2-1);
    y       =   0.5*(cos(pi*(x-nBlkSz/2)/nOvrlp)+1);
    y(abs(x)<nBlkSz/2)=1;
%end function raised_cosine

%-----------------------------------
%raised_cosine_window
%returns 2D spectral window
%syntax:
%w = raised_cosine_window(blksz,ovrlp)
%w      - [OUT] 1D raised cosine function
%nBlkSz - [IN]  the window is constant here
%nOvrlp - [IN]  the window has transition here
%-----------------------------------
function w = raised_cosine_window(blksz,ovrlp)
    y = raised_cosine(blksz,ovrlp);
    w = y(:)*y(:)';
%end function raised_cosine_window

%---------------------------------------------------------------------
%get_angular_filter
%generates an angular filter centered around 'th' and with bandwidth 'bw'
%the filters in angf_xx are precomputed using angular_filter_bank.m
%syntax:
%r = get_angular_filter(t0,bw)
%r - [OUT] angular filter of size NFFTxNFFT
%t0- mean angle (obtained from orientation image)
%bw- angular bandwidth(obtained from bandwidth image)
%angf_xx - precomputed filters (using angular_filter_bank.m)
%-----------------------------------------------------------------------
function rmsk = get_angular_filter(t0,BW)
     global NFFT;
     [x,y]   =   meshgrid(-NFFT/2:NFFT/2-1,-NFFT/2:NFFT/2-1);
     r       =   sqrt(x.^2+y.^2);
     th      =   atan2(y,x);
     th(th<0)=   th(th<0)+2*pi;  %unsigned
     t1      =   mod(t0+pi,2*pi);
     %-----------------
     %first lobe
     %-----------------
     d          = angular_distance(th,t0);
     msk        = 1+cos(d*pi/BW); 
     msk(d>BW)  = 0;
     rmsk       = msk;                              %save first lobe

     %-----------------
     %second lobe
     %-----------------
     d          = angular_distance(th,t1);
     msk        = 1+cos(d*pi/BW); 
     msk(d>BW)  = 0;
     rmsk       = (rmsk+msk);
%end function



%---------------------------------------------------------------------
%get_radial_filter
%generates an radial filter
%syntax:
%r = get_radial_filter(r0)
%r - [OUT] angular filter of size NFFTxNFFT
%r0- center frequency
%-----------------------------------------------------------------------
function rmsk = get_radial_filter(r0)
     global NFFT;
     N          =   4;
     r0         =   NFFT/r0;
     BW         =   r0*1.75-r0/1.75;
     [x,y]      =   meshgrid(-NFFT/2:NFFT/2-1,-NFFT/2:NFFT/2-1);
     r          =   sqrt(x.^2+y.^2);
     num        =   (r*BW).^(2*N);
     den        =   (r*BW).^(2*N)+((r.^2-r0.^2)).^(2*N);
     rmsk       =   sqrt(num./den);
%end function get_radial_filter

%-----------------------------------------------------------
%get_angular_bw_image
%the bandwidth allocation is currently based on heuristics
%(domain knowledge :)). 
%syntax:
%bwimg = get_angular_bw_image(c)
%-----------------------------------------------------------
function bwimg = get_angular_bw_image(c)
    bwimg   =   zeros(size(c));
    bwimg(:,:)    = pi/2;                       %med bw
    bwimg(c<=0.7) = pi;                         %high bw
    bwimg(c>=0.9) = pi/6;                       %low bw
%end function get_angular_bw


%-----------------------------------------------------------
%get_angular_bw_image
%the bandwidth allocation is currently based on heuristics
%(domain knowledge :)). 
%syntax:
%bwimg = get_angular_bw_image(c)
%-----------------------------------------------------------
function mth = compute_mean_angle(dEnergy,th)
    global NFFT;
    sth         =   sin(2*th);
    cth         =   cos(2*th);
    num         =   sum(sum(dEnergy.*sth));
    den         =   sum(sum(dEnergy.*cth));
    mth         =   0.5*atan2(num,den);
    if(mth <0)
        mth = mth+pi;
    end;
%end function compute_mean_angle

%-----------------------------------------------------------
%get_angular_bw_image
%the bandwidth allocation is currently based on heuristics
%(domain knowledge :)). 
%syntax:
%bwimg = get_angular_bw_image(c)
%-----------------------------------------------------------
function mr = compute_mean_frequency(dEnergy,r)
    global NFFT;
    num         =   sum(sum(dEnergy.*r));
    den         =   sum(sum(dEnergy));
    mr          =   num/(den+eps);
%end function compute_mean_angle


%-----------------------------------------
%angular_distance
%computes angular distance-acute angle 
%-----------------------------------------
function d = angular_distance(th,t0)
    d = abs(th-t0);
    d = min(d,2*pi-d);
%end function angular_distance

%-----------------------------------------------------
%imscale
%normalizes the image to range [0-1]
%-----------------------------------------------------
function y = imscale(x)
    mn = min(min(x));
    mx = max(max(x));
    y  = (x-mn)/(mx-mn);
%end function imscale

%--------------------------------------------------------------------------
%  Version 1.0 March 2005
%  Copyright (c) 2005-2010 by Center for Unified Biometrics and Sensors
%  www.cubs.buffalo.edu
%
%otsu_threshold
%implements otsu's thresholding method
%Contact:
%   ssc5@eng.buffalo.edu
%   www.eng.buffalo.edu/~ssc5
%Reference:
%Otsu, A Threshold Selection Method from Gray-Level Histogram, IEEE Trans.
%on Systems, Man and Cybernetics, 1979
%--------------------------------------------------------------------------
function t = otsu_threshold(img)
    %obtain probability
    [ht,wt] = size(img);
    [p,x]   = imhist(img,256);
    p       = p/(ht*wt);
    w       = zeros(1,256);
    m       = zeros(1,256);
    w(1)    = p(1);
    m(1)    = p(1);
    for i=2:256
        w(i)= w(i-1)+p(i);
        m(i)= i*p(i)+m(i-1);
    end;
    mt = m(end);
    w  = w+eps;
    sigma_b = ((mt*w-m).^2)./(w.*(1-w));
    t       = find(sigma_b == max(sigma_b));
    t       = x(t(1));
%end function

%--------------------------------------------------------------------------
%  Version 1.0 March 2005
%  Copyright (c) 2005-2010 by Center for Unified Biometrics and Sensors
%  www.cubs.buffalo.edu
%
%segment_print
%segments the fingerprint region from the background based on morphological
%operations
%syntax:
% [msk]= segment_print(img,iters,verbose)
% img       - original image 
% verbose   - a value of 1 displays intermediate results
%Contact:
%   ssc5@cubs.buffalo.edu, sharat@mit.edu
%   http://www.sharat.org
%--------------------------------------------------------------------------
function msk    =   segment_print(img,verbose)
    [ht,wt]     =   size(img);
    y           =   im2double(img);
    img         =   im2double(img);
    ITERS       =   4;
    %-----------------
    %compute the mask
    %-----------------
    for i=1:ITERS
        y           =   imerode(y,ones(5,5));      %diffuse blob
        c           =   y.^2;                       %enhance contrast
        msk         =   ~im2bw(c,otsu_threshold(c)); %find mask
        %---------------------------------------------------
        %remove sections that might grow to join main blob
        %---------------------------------------------------
        if(i == 2)
            small       =   msk & ~bwareaopen(msk,floor(0.1*ht*wt),4);
            y(small==1) =   sum(sum(img))/(ht*wt);
        end;

        %---------------------------------------------------
        %display intermediate result
        %---------------------------------------------------
        if(verbose==1)
            subplot(1,4,1),imagesc(img),title('Original');
            subplot(1,4,2),imagesc(y),title('Eroded');
            subplot(1,4,3),imagesc(c);colormap('gray'),title('Enhanced');
            subplot(1,4,4),imagesc(msk),title('Segmented');
            pause;
            drawnow;
        end;
    end;
    %----------------------------------------
    %get the largest blob as the fingerprint
    %----------------------------------------
    msk = bwareaopen(msk,round(0.15*ht*wt));
    msk = imerode(msk,ones(7,7));           %erode boundary
    msk = imfill(msk,'holes');              %fill holes

    %---------------------------------------------------
    %display final result
    %---------------------------------------------------
    if(verbose==1)
        figure,imagesc(msk.*img),axis image,colormap('gray'),title('Final');
    end;
%end function isotropic_diffusion

%------------------------------------------------------------------------
%compute_coherence
%Computes the coherence image. 
%Usage:
%[cimg] = compute_coherence(oimg)
%oimg - orientation image
%cimg - coherence image(0-low coherence,1-high coherence)
%Contact:
%   ssc5@cubs.buffalo.edu, sharat@mit.edu
%   http://www.sharat.org
%Reference:
%A. Ravishankar Rao,"A taxonomy of texture description", Springer Verlag
%------------------------------------------------------------------------
function [cimg] = compute_coherence(oimg)
    [h,w]   =   size(oimg);
    cimg    =   zeros(h,w);
    N       =   2;
    %---------------
    %pad the image
    %---------------
    oimg    =   [flipud(oimg(1:N,:));oimg;flipud(oimg(h-N+1:h,:))]; %pad the rows
    oimg    =   [fliplr(oimg(:,1:N)),oimg,fliplr(oimg(:,w-N+1:w))]; %pad the cols
    %compute coherence
    for i=N+1:h+N
        for j = N+1:w+N
            th  = oimg(i,j);
            blk = oimg(i-N:i+N,j-N:j+N);
            cimg(i-N,j-N)=sum(sum(abs(cos(blk-th))))/((2*N+1).^2);
        end;
    end;
%end function compute_coherence

%------------------------------------------------------------------------
%smoothen_frequency_image
%smoothens the frequency image through a process of diffusion
%Usage:
%new_oimg = smoothen_frequency_image(fimg,RLOW,RHIGH,diff_cycles)
%fimg       - frequency image image
%nimg       - filtered frequency image
%RLOW       - lowest allowed ridge separation
%RHIGH      - highest allowed ridge separation
%diff_cyles - number of diffusion cycles
%Contact:
%   ssc5@cubs.buffalo.edu sharat@mit.edu
%   http://www.sharat.org
%Reference:
%1. S. Chikkerur, C.Wu and V. Govindaraju, "Systematic approach for feature
%   extraction in Fingerprint Images", ICBA 2004
%2. S. Chikkerur and V. Govindaraju, "Fingerprint Image Enhancement using 
%   STFT Analysis", International Workshop on Pattern Recognition for Crime 
%   Prevention, Security and Surveillance, ICAPR 2005
%3. S. Chikkeur, "Online Fingerprint Verification", M. S. Thesis,
%   University at Buffalo, 2005
%4. T. Jea and V. Govindaraju, "A Minutia-Based Partial Fingerprint Recognition System", 
%   to appear in Pattern Recognition 2005
%5. S. Chikkerur, "K-plet and CBFS: A Graph based Fingerprint
%   Representation and Matching Algorithm", submitted, ICB 2006
% See also: cubs_visualize_template
%------------------------------------------------------------------------
function nfimg = smoothen_frequency_image(fimg,RLOW,RHIGH,diff_cycles)
    valid_nbrs  =   3; %uses only pixels with more then valid_nbrs for diffusion
    [ht,wt]     =   size(fimg);
    nfimg       =   fimg;
    N           =   1;
    
    %---------------------------------
    %perform diffusion
    %---------------------------------
    h           =   fspecial('gaussian',2*N+1);
    cycles      =   0;
    invalid_cnt = sum(sum(fimg<RLOW | fimg>RHIGH));
    while((invalid_cnt>0 &cycles < diff_cycles) | cycles < diff_cycles)
        %---------------
        %pad the image
        %---------------
        fimg    =   [flipud(fimg(1:N,:));fimg;flipud(fimg(ht-N+1:ht,:))]; %pad the rows
        fimg    =   [fliplr(fimg(:,1:N)),fimg,fliplr(fimg(:,wt-N+1:wt))]; %pad the cols
        %---------------
        %perform diffusion
        %---------------
        for i=N+1:ht+N
         for j = N+1:wt+N
                blk = fimg(i-N:i+N,j-N:j+N);
                msk = (blk>=RLOW & blk<=RHIGH);
                if(sum(sum(msk))>=valid_nbrs)
                    blk           =blk.*msk;
                    nfimg(i-N,j-N)=sum(sum(blk.*h))/sum(sum(h.*msk));
                else
                    nfimg(i-N,j-N)=-1; %invalid value
                end;
         end;
        end;
        %---------------
        %prepare for next iteration
        %---------------
        fimg        =   nfimg;
        invalid_cnt =   sum(sum(fimg<RLOW | fimg>RHIGH));
        cycles      =   cycles+1;
    end;
    cycles
%end function smoothen_orientation_image
%------------------------------------------------------------------------
%smoothen_orientation_image
%smoothens the orientation image through vectorial gaussian filtering
%Usage:
%new_oimg = smoothen_orientation_image(oimg)
%oimg     - orientation image
%new_oimg - filtered orientation image
%Contact:
%   ssc5@cubs.buffalo.edu,sharat@mit.edu
%   http://www.sharat.org
%Reference:
%M. Kaas and A. Witkin, "Analyzing oriented patterns", Computer Vision
%Graphics Image Processing 37(4), pp 362--385, 1987
%------------------------------------------------------------------------
function noimg = smoothen_orientation_image(oimg)
    %---------------------------
    %smoothen the image
    %---------------------------
    gx      =   cos(2*oimg);
    gy      =   sin(2*oimg);
    
    msk     =   fspecial('gaussian',5);
    gfx     =   imfilter(gx,msk,'symmetric','same');
    gfy     =   imfilter(gy,msk,'symmetric','same');
    noimg   =   atan2(gfy,gfx);
    noimg(noimg<0) = noimg(noimg<0)+2*pi;
    noimg   =   0.5*noimg;
%end function smoothen_orientation_image