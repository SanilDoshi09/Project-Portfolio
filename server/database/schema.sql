-- Users Table
CREATE TABLE Users (
    UserID SERIAL PRIMARY KEY,
    Username VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    DateJoined DATETIME NOT NULL
);

-- Portfolio Table
CREATE TABLE Portfolio (
    PortfolioID SERIAL PRIMARY KEY,
    UserID INT NOT NULL,
    PortfolioName VARCHAR(255) NOT NULL,
    DateCreated DATETIME NOT NULL,
    LastUpdated DATETIME NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Asset Types Table
CREATE TABLE AssetTypes (
    AssetTypeID SERIAL PRIMARY KEY,
    AssetTypeName VARCHAR(255) NOT NULL
);

-- Assets Table
CREATE TABLE Assets (
    AssetID SERIAL PRIMARY KEY,
    PortfolioID INT NOT NULL,
    AssetTypeID INT NOT NULL,
    TickerSymbol VARCHAR(60) NOT NULL,
    AssetName VARCHAR(255) NOT NULL,
    Quantity NUMERIC NOT NULL,
    AverageCost NUMERIC NOT NULL,
    DateAcquired DATETIME NOT NULL,
    FOREIGN KEY (PortfolioID) REFERENCES Portfolio(PortfolioID),
    FOREIGN KEY (AssetTypeID) REFERENCES AssetTypes(AssetTypeID),
    UNIQUE (TickerSymbol)
);

-- Transactions Table
CREATE TABLE Transactions (
    TransactionID SERIAL PRIMARY KEY,
    AssetID INT NOT NULL,
    PortfolioID INT NOT NULL,
    AssetTypeID INT NOT NULL,
    TransactionType VARCHAR(255) NOT NULL,
    Quantity NUMERIC NOT NULL,
    Price NUMERIC NOT NULL,
    TransactionDate DATETIME NOT NULL,
    FOREIGN KEY (AssetID) REFERENCES Assets(AssetID),
    FOREIGN KEY (PortfolioID) REFERENCES Portfolio(PortfolioID),
    FOREIGN KEY (AssetTypeID) REFERENCES AssetTypes(AssetTypeID)
);

-- HistoricalData Table
CREATE TABLE HistoricalDate (
    DataID SERIAL PRIMARY KEY,
    AssetID INT NOT NULL,
    Date DATETIME NOT NULL,
    Price NUMERIC NOT NULL,
    Volume INT,
    FOREIGN KEY (AssetID) REFERENCES Assets(AssetID)    
);

-- FinancialMetrics Table
CREATE TABLE FinancialMetrics (
    MetricID SERIAL PRIMARY KEY,
    PortfolioID INT NOT NULL,
    Metric VARCHAR(255) NOT NULL,
    Value FLOAT NOT NULL,
    DateMeasured DATETIME NOT NULL,
    FOREIGN KEY (PortfolioID) REFERENCES Portfolio(PortfolioID)    
);