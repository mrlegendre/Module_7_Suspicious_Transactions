
-- Create table merchant_category
CREATE TABLE merchant_category (
  id INTEGER PRIMARY KEY,
  name VARCHAR NOT NULL
);

--Create table merchant 'id_merchant_category' is FOREIGN KEY references 'id' in "merchant_category table"
CREATE TABLE merchant (
  id INTEGER PRIMARY KEY,
  name VARCHAR NOT NULL,
  id_merchant_category INT NOT NULL,
  FOREIGN KEY (id_merchant_category) REFERENCES merchant_category(id)
);

--Create table transaction 'card' is FOREIGN KEY references 'card' in "credit_card table" and 'id_merchant' is FOREIGN KEY references to 'id' in "merchant table"
CREATE TABLE transaction (
  id INTEGER PRIMARY KEY,
  date timestamp without time zone NOT NULL,
  amount decimal NOT NULL,
  card VARCHAR(20) NOT NULL,
  FOREIGN KEY (card) REFERENCES credit_card(card),
  id_merchant INTEGER NOT NULL,
  FOREIGN KEY (id_merchant) REFERENCES merchant(id)
);