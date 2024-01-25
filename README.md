# Data Analytics Power BI Report

The purpose of this project was to build a series of report pages for a retailer to highlight some insights into their business in order to help build their business intelligence. 

In this README, I'll go over how I achieved each milestone

## Milestone 1 

Simply setting up the GitHub repository for the project

## Milestone 2

This involved loading all the necessary tables into Power BI. Loading the Orders table involved connecting to the Azure SQL Database. Once I had the table, I split up the [Order Date] and [Shipping Date] columns into one for the date and one for the time. 

For the Products table, I had to download a .csv file and load it into Power BI. To clean up the (weight) column, I had to split this into the weight and the units. Using columns from examples, this was easily achieved. I did have to note some of the edge cases and manually fix them (for example, one of the weights was a multipack and I only had the weight of an individual product, so I had to multiply the number of products in the multipack with the number of items present).

For the Stores table, I had to connect to a blob storage to import the table, which was a simple process. 

Finally, the Customers table just came as a .zip file, so after loading this into Power BI, it automatically appended the 3 files present inside.

## Milestone 3

This involved creating the data model. The first step was to create the date table, which ran from the earliest date in the [Order Date] column to the final date in the [Shipping Date] column. To make sure I had the correct dates, I first went to the [Order Date] column and sorted by ascending to find the first date and make note of the date. I did the same for the [Shipping Date] but sorted by descending to get the most recent date. Now I could make my dates table using the expression 

```dax 
Dates = CALENDAR(DATE(2010,1,1), DATE(2022,31,12))
```
The next step was to build the Star Schema model. Here is the completed model: 

![Local Image]("C:\Users\msyne\Desktop\star_schema.png")

Next, I had to create a measures table for the key measures. These were the following:

```dax
Total Orders = COUNT(orders_powerbi[Order Date])

Total Revenue = SUMX(orders_powerbi, orders_powerbi[Product Quantity]* RELATED(Products[Sale Price]))

Total Profit = SUMX(orders_powerbi, orders_powerbi[Product Quantity]*'Measures Table'[Profit])

Total Customers = COUNTROWS(SUMMARIZE(orders_powerbi, orders_powerbi[User ID]))

Total Quantity = COUNT(orders_powerbi[Order Date])

ProfitYTD = TOTALYTD([Total Profit], orders_powerbi[Order Date])

RevenueYTD = TOTALYTD([Total Revenue], orders_powerbi[Order Date])
```

With the name of each measure being self-explanatory in what it's purpose is.

Finally, I had to create a date and geography hierarchy. The date hiearchy was quite simple, and the levels were:

- Start of Year
- Start of Quarter
- Start of Month
- Start of Week
- Date

The geography hierarchy has the levels:

- World region
- Country
- Country Region

## Milestone 4

Here I just set up the report by creating the pages and adding an empty navigation sidebar.

## Milestone 5 - Customer Detail Page