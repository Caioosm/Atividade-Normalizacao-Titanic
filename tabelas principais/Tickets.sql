CREATE TABLE Tickets (
    TicketId INT PRIMARY KEY,
    TicketNumber VARCHAR(50),
    Fare DECIMAL(10,2),
    ClassId INT,
    FOREIGN KEY (ClassId) REFERENCES Classes(ClassId)
);