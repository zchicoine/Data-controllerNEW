Access the Amazon web Server DynamoDB

Information about DynamoDB
 - In Amazon DynamoDB, a database is a collection of tables. A table is a collection of items and each item is a collection of attributes.
 -  DynamoDB only requires that a table has a primary key, but does not require you to define all of the attribute names and data types in advance
 - Each attribute in an item is a name-value pair. An attribute can be single-valued or multi-valued set. For example, a book item can have title and authors attributes.
 - Each book has one title but can have many authors. The multi-valued attribute is a set; duplicate values are not allowed.


 DynamoDB supports the following two types of primary keys:

 - Hash Type Primary Key: The primary key is made of one attribute, a hash attribute.
    DynamoDB builds an unordered hash index on this primary key attribute.
    Each item in the table is uniquely identified by its hash key value.
 - Hash and Range Type Primary Key: The primary key is made of two attributes.
    The first attribute is the hash attribute and the second one is the range attribute.
    DynamoDB builds an unordered hash index on the hash primary key attribute, and a sorted range index on the range primary key attribute.
    Each item in the table is uniquely identified by the combination of its hash and range key values.
    It is possible for two items to have the same hash key value, but those two items must have different range key values.