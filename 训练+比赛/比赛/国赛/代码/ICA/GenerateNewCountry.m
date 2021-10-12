function NewCountry = GenerateNewCountry(NumOfCountries,ProblemParams)
    VarMinMatrix = repmat(ProblemParams.VarMin,NumOfCountries,1);
    VarMaxMatrix = repmat(ProblemParams.VarMax,NumOfCountries,1);
    NewCountry = (VarMaxMatrix - VarMinMatrix) .* rand(size(VarMinMatrix)) + VarMinMatrix;
end