-- Users Table
CREATE TABLE Users (
    UserID SERIAL PRIMARY KEY,
    Username VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    DateJoined TIMESTAMP NOT NULL
);

-- Portfolio Table
CREATE TABLE Portfolio (
    PortfolioID SERIAL PRIMARY KEY,
    UserID INT NOT NULL,
    PortfolioName VARCHAR(255) NOT NULL,
    DateCreated TIMESTAMP NOT NULL,
    LastUpdated TIMESTAMP NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- AssetType Table
CREATE TABLE AssetType (
    AssetTypeID SERIAL PRIMARY KEY,
    AssetTypeName VARCHAR(255) NOT NULL UNIQUE
);

-- Assets Table
CREATE TABLE Assets (
    AssetID SERIAL PRIMARY KEY,
    PortfolioID INT NOT NULL,
    AssetTypeID INT NOT NULL,
    TickerSymbol VARCHAR(60) NOT NULL,
    AssetName VARCHAR(255) NOT NULL,
    Quantity NUMERIC CHECK (Quantity >= 0) NOT NULL,
    AverageCost NUMERIC CHECK (AverageCost >= 0) NOT NULL,
    DateAcquired TIMESTAMP NOT NULL,
    CONSTRAINT fk_portfolio FOREIGN KEY (PortfolioID) REFERENCES Portfolio(PortfolioID),
    CONSTRAINT fk_assettype FOREIGN KEY (AssetTypeID) REFERENCES AssetType(AssetTypeID),
    UNIQUE (PortfolioID, TickerSymbol)
);

-- Transactions Table
CREATE TABLE Transactions (
    TransactionID SERIAL PRIMARY KEY,
    AssetID INT NOT NULL,
    PortfolioID INT NOT NULL,
    AssetTypeID INT NOT NULL,
    TransactionType VARCHAR(255) NOT NULL,
    Quantity NUMERIC CHECK (Quantity >= 0) NOT NULL,
    Price NUMERIC CHECK (Price >= 0) NOT NULL,
    TransactionDate TIMESTAMP NOT NULL,
    CONSTRAINT fk_asset FOREIGN KEY (AssetID) REFERENCES Assets(AssetID),
    CONSTRAINT fk_portfolio FOREIGN KEY (PortfolioID) REFERENCES Portfolio(PortfolioID),
    CONSTRAINT fk_assettype FOREIGN KEY (AssetTypeID) REFERENCES AssetType(AssetTypeID)
);

-- HistoricalData Table
CREATE TABLE HistoricalData (
    DataID SERIAL PRIMARY KEY,
    AssetID INT NOT NULL,
    Date TIMESTAMP NOT NULL,
    Price NUMERIC CHECK (Price >= 0) NOT NULL,
    Volume INT,
    CONSTRAINT fk_asset FOREIGN KEY (AssetID) REFERENCES Assets(AssetID)
);

-- FinancialMetrics Table
CREATE TABLE FinancialMetric (
    MetricID SERIAL PRIMARY KEY,
    PortfolioID INT NOT NULL,
    Metric VARCHAR(255) NOT NULL,
    Value FLOAT NOT NULL,
    DateMeasured TIMESTAMP NOT NULL,
    CONSTRAINT fk_portfolio FOREIGN KEY (PortfolioID) REFERENCES Portfolio(PortfolioID)    
);
