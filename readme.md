# EXERCICIO - Normalização de Dados do Titanic

## Introdução

Este projeto tem como objetivo normalizar os dados dos passageiros do Titanic, aplicando as três primeiras formas normais (1NF, 2NF e 3NF) para evitar redundâncias e melhorar a integridade e eficiência do banco de dados.

A normalização foi realizada com base nos seguintes atributos:

- **PassengerId** (ID do Passageiro)
- **Nome**
- **Sexo**
- **Idade**
- **Classe (Pclass)**
- **Tarifa (Fare)**
- **Porto de Embarque (Embarked)**
- **Número do Bilhete (Ticket)**
- **Cabine (Cabin)**
- **Status de Sobrevivência (Survived)**

## Etapas da Normalização

### 1. Primeira Forma Normal (1NF)

A 1NF exige que cada coluna tenha valores atômicos, ou seja, sem listas ou conjuntos de dados em uma única célula. Ajustes feitos:

- Separar os dados da coluna **Cabin**, pois um passageiro pode ter mais de uma cabine atribuída.
- Criar tabelas separadas para **Portos de Embarque** e **Classes** para evitar repetições desnecessárias.

### 2. Segunda Forma Normal (2NF)

A 2NF exige que todos os atributos dependam completamente da chave primária. Ajustes feitos:

- A informação sobre a **classe da passagem (Pclass)** foi movida para uma tabela separada, já que dados relacionados à classe podem ser compartilhados por vários passageiros.
- **Tarifas** foram mantidas na tabela de **Tickets**, pois passageiros diferentes podem compartilhar o mesmo bilhete.

### 3. Terceira Forma Normal (3NF)

A 3NF elimina dependências transitivas (quando um atributo depende de outro atributo que não é a chave primária). Ajustes feitos:

- A descrição do porto de embarque foi movida para a tabela **Portos**.
- As informações da tarifa passaram a pertencer à tabela **Tickets**.

## Estrutura do Banco de Dados

Foram criadas as seguintes tabelas:

### 1. Tabela `Passengers`

Armazena informações individuais dos passageiros.

```sql
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
```

### 2. Tabela `Ports`

Armazena os portos de embarque.

```sql
CREATE TABLE Ports (
    EmbarkedCode CHAR(1) PRIMARY KEY,
    EmbarkedName VARCHAR(50)
);
```

### 3. Tabela `Classes`

Armazena as classes de passagem e suas informações adicionais.

```sql
CREATE TABLE Classes (
    ClassId INT PRIMARY KEY,
    ClassName VARCHAR(20),
    AverageFare DECIMAL(10,2)
);
```

### 4. Tabela `Tickets`

Armazena os bilhetes e suas tarifas.

```sql
CREATE TABLE Tickets (
    TicketId INT PRIMARY KEY,
    TicketNumber VARCHAR(50),
    Fare DECIMAL(10,2),
    ClassId INT,
    FOREIGN KEY (ClassId) REFERENCES Classes(ClassId)
);
```

## Diagrama Entidade-Relacionamento (DER)

![DER](https://github.com/user-attachments/assets/ea0cadfb-191c-4509-9fa3-81eff2436a8a)

## Benefícios da Normalização

1. **Elimina redundâncias**: Reduz o armazenamento desnecessário de dados repetidos.
2. **Melhora a integridade dos dados**: Atualizações são propagadas de maneira consistente.
3. **Facilita consultas eficientes**: Com menos repetições, as buscas são mais rápidas e organizadas.
4. **Evita anomalias de inserção, remoção e atualização**.

## Consultas SQL referenciando as sugestoes passadas

### 1. Distribuição dos Sobreviventes por Porto

```sql
SELECT p.EmbarkedName, COUNT(ps.PassengerId) AS Total, SUM(ps.Survived) AS Sobreviventes
FROM Passengers ps
JOIN Ports p ON ps.EmbarkedCode = p.EmbarkedCode
GROUP BY p.EmbarkedName;
```

### 2. Contagem de Sobreviventes por Classe

```sql
SELECT c.ClassName, SUM(ps.Survived) AS Sobreviventes, COUNT(ps.PassengerId) - SUM(ps.Survived) AS Nao_Sobreviventes
FROM Passengers ps
JOIN Tickets t ON ps.TicketId = t.TicketId
JOIN Classes c ON t.ClassId = c.ClassId
GROUP BY c.ClassName;
```

### 3. Passageiros Não Sobreviventes Ordenados por Idade

```sql
SELECT Name, Age, Sex
FROM Passengers
WHERE Survived = 0
ORDER BY Age DESC;
```

### 4. Join entre Passageiros e Portos de Embarque

```sql
SELECT ps.Name, p.EmbarkedName, ps.Survived
FROM Passengers ps
JOIN Ports p ON ps.EmbarkedCode = p.EmbarkedCode;
```

### 5. Cálculo da Tarifa Média por Classe

```sql
SELECT c.ClassName, AVG(t.Fare) AS Tarifa_Media
FROM Tickets t
JOIN Classes c ON t.ClassId = c.ClassId
GROUP BY c.ClassName;
```

## Conclusao

A normalização aplicada ao banco de dados do Titanic melhora a organização e a eficiência do sistema. Evita dados redundantes, melhora a integridade dos dados e facilita a realização de consultas complexas. No final, a estrutura do banco se torna mais fácil de manter e escalável para futuras análises.
