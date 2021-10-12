function [out] = m_connect(in);

% apply m_connectivity to the one pixel wide image
% 2/12


[w,h] = size(in);

out=in;

for i=3:h-2

	for j = 3:w-2


		if out(i,j) == 1 & out(i+1,j+1) == 1

			out(i+1,j) = 0;
			out(i,j+1) = 0;

		end;

		if out(i,j) == 1 & out(i-1,j+1) == 1

			out(i,j+1) = 0;
			out(i-1,j) = 0;

		end;


	end;
end;
imagesc(out);