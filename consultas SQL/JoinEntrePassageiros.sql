--  Join entre Passageiros e Portos de Embarque

SELECT ps.Name, p.EmbarkedName, ps.Survived
FROM Passengers ps
JOIN Ports p ON ps.EmbarkedCode = p.EmbarkedCode;