-- contagem Sobreviventes por Classes

SELECT c.ClassName, SUM(ps.Survived) AS Sobreviventes, COUNT(ps.PassengerId) - SUM(ps.Survived) AS Nao_Sobreviventes
FROM Passengers ps
JOIN Tickets t ON ps.TicketId = t.TicketId
JOIN Classes c ON t.ClassId = c.ClassId
GROUP BY c.ClassName;