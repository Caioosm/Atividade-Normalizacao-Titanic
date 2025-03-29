-- Passageiros Não Sobreviventes Ordenados por Idade

SELECT Name, Age, Sex
FROM Passengers
WHERE Survived = 0
ORDER BY Age DESC;