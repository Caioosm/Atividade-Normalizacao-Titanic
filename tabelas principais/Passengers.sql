CREATE TABLE Passengers (
    PassengerId INT PRIMARY KEY,
    Name VARCHAR(255),
    Sex VARCHAR(10),
    Age DECIMAL(4,2),
    TicketId INT,
    Cabin VARCHAR(50),
    Survived BOOLEAN,
    EmbarkedCode CHAR(1),
    FOREIGN KEY (TicketId) REFERENCES Tickets(TicketId),
    FOREIGN KEY (EmbarkedCode) REFERENCES Ports(EmbarkedCode)
);