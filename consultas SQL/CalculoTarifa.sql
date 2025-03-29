-- Cálculo da Tarifa Média por Classe

SELECT c.ClassName, AVG(t.Fare) AS Tarifa_Media
FROM Tickets t
JOIN Classes c ON t.ClassId = c.ClassId
GROUP BY c.ClassName;