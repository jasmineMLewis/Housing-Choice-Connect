# Housing Choice Connect


# Table of Contents

1. [General Information](#general-information)
2. [Introduction](#introduction)
3. [Installation](#installation)
4. [Application Details](#application-details)
5. [Database Composition](#database-composition)
 
# General Information

## Company 
Housing Authority of New Orleans

### Industry
Housing

### Project Type
House Listings

## Project Description
Housing Choice Connect allows New Orleans voucher holders and participating landlords to 
easily search or advertise rental properties without reviewing an extensive list.

### Project Link
https://www.hano.org/HousingChoiceConnect/

### Project GitHub
https://github.com/jasmineMLewis/Housing-Choice-Connect


# Introduction
Housing Choice Connect is a .NET project for Housing Authority of New Orleans.

### Version
<p>Major.Minor.Patch</p>
<p>Old project from late 2010s (2016 - 2017)</p>

<b>New Updates Added as of 2024</b>
1. Add a Application Constants Class as pascal case variables
2. (IN PROGRESS) Change each page that uses local constants to Application Constants namespace 
1. (IN PROGRESS) Create schemas


### Date Last Updated via GitHub
September 20, 2024

### Technologies
| Technology | Version  |
|--|--|
| ASP.NET Web Application (.NET Framework) | 4.7.2 |
| Bootstrap | 5.2.3 |
| Font Awesome | 6.3.0 |
| JQuery | 5.2.3 |


# Installation

## Install Applications
1. Download MicroSoft (MS) SQL Server Managment Studio
2. Download MicroSoft (MS) Visual Studio 2022

## Install Database
Within the File-Tracker folder, navigate to database folder, and open the following folders:
1. create-tbls-sql
2. insert-data-sql

### Create Tables
Execute database files in SQL Server Managment Studio within 'create-tbls-sql' folder:
1. ./database/create-tbls-sql/1-1-create-tbls-refernce.sql
2. ./database/create-tbls-sql/1-2-create-tbls-permanent.sql
3. ./database/create-tbls-sql/1-3-create-tbls-link.sql


### Insert Data
Execute database files in SQL Server Managment Studio within 'insert-data-sql' folder:
1. ./database/insert-data-sql/2-1-insert-data-tbls-refernce.sql
2. ./database/insert-data-sql/2-2-insert-data-tbls-permanent.sql


## Run Application
1. Open FileTracker project folder (contains FileTracker.sln) in MS Visual Studio 2022
2. Navigate to Web.Config, modify database host and password to your localhost credentials
3. After the application is open in Visual Studio, press IIS Express on the top tool bar


# Application Details
Housing Choice Connect's folders are Sign In, Sign Up, Tenants, Landlords, and Admins.
1. [Sign In](#sign-in)
2. [Sign Up](#sign-up)
3. [Tenants](#tenants)
4. [Landlords](#landlords)
5. [Admins](#admins)


## Sign In
> Login Users

## Sign Up
> Register Users

## Tenants
>

## Landlords
>

## Admins
> 


# Database Composition
## Reference  Tables
> Reference Tables share identical fields/column data in another table.
(Ordered by Relevance):
1. 

## Permanent Tables
> Permanent Tables have their own table structure, columns, data types, constraints and indexes.
(Ordered by Relevance):
1. 

