function NewCountry = GenerateNewCountry(NumOfCountries,ProblemParams)
for i = 1:NumOfCountries
    temp = randperm(ProblemParams.VarMax);
    NewCountry(i,:) = temp(1:ProblemParams.NPar);
    NewCountry(i,:) = sort(NewCountry(i,:));
end