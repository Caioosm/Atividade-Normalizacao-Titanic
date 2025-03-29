SELECT p.EmbarkedName, COUNT(ps.PassengerId) AS Total, SUM(ps.Survived) AS Sobreviventes
FROM Passengers ps
JOIN Ports p ON ps.EmbarkedCode = p.EmbarkedCode
GROUP BY p.EmbarkedName;