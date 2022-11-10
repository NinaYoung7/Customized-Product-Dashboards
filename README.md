# Dynamic Product Dashboard and reporting - a telecommunications company 

Submitted by: **NING YANG**

Time spent: **40** hours spent in total

Tools Used: R(datatable,shiny,flexdashboard)


This project is a part of Course APANPS5902 - DATA SCIENCE CONSULTING in Columbia University.


## Description

A large telecommunications company conducts a marketing survey to better understand the perceptions about their products and the competition. Our consulting team has worked with the company to identify a variety of questions to answer.
I also build a dynamic reporting engine that can be run as a shiny application in R to benefit them.

In addition to building these tools, I also identify opportunities for the client to make use of the information as a data scientist in the consulting team.

<img width="1154" alt="image" src="https://user-images.githubusercontent.com/103723722/201201689-6a011040-8d0c-47a8-96d7-3823f72213bb.png">


## Before you run the code

Keep the files in a folder structure:

⦿ The Project's Folder:

     ○ Data
   
     ○ Reports
   
         • .rmd files
       
         • .R files
       
       
The Rmarkdown file should be within the Reports subfolder.  It should read the data from the Data folder using relative directories:


```
dat <- fread(input = "../Data/mobile phone survey data.csv", verbose = F)
```

## Part 1: Summarizing the data.

This part is the summary of the information and  is directed to the internal team at the consulting company. It is intended to document the sources of information that were used in the project. It  also describes the data in less technical terms to team members who are not data scientists. If another member of the team joins the project later, they will rely on your descriptions to gain familiarity with the data. 

## Part 2: Answering specific questions about the respondents and their perceptions of the industry’s products.

This part of the report is directed to marketing and product managers throughout the client’s company. The idea is to give them the useful information they need to act on the specific questions they posed. 


## Part 3: Building a dynamic reporting engine to explore many facets of the survey’s information.

Each of the specific questions in Part 2 can be generalized. A reporting engine can allow a user to select many different outcomes or subgroups to explore. In this portion, I construct a dynamic reporting engine as a shiny application in R. 

Between Parts 2 and 3, there are two kinds of reports – one static and one dynamic. 

I created two addtional files:
constants.R
functions.R

Many of the initial commonalities in the two reports can be unified by referring to the constants and functions. For each specific question in Part 2, I created a single function that can be called to answer it and also be called in the dynamic reporting engine of Part 3.

### Questions:

### 1. Respondent Variables
Depict the information produced in Q1 of Part 2. Allow the user to select which variable to explore. Then create a graph that depicts the percentages of respondents in each category for that variable.
### 2. Segmented Outcomes
Build a dynamic, visual display ranking the products by their outcomes in the manner of Question 2 of Part 2. The user will make the following selections:

State of engagement: Only a single state may be selected at once.

Other variables: Age Group, Gender, Income Group, Region, Persona

Then, for all of the other variables, any combination of categories may be selected, so long as at least one category from each variable is chosen. For instance, for Gender, the user may select Male only, Female only, or both Male and Female.

Then, the user should be able to select how many products to display. Once a number is selected, the outcome rates should be graphically displayed in sorted decreasing order for the top products in the selected subgroups. If 5 is selected for Awareness, then the 5 products with the highest rates of Awareness for the specified subgroup will be depicted.

### 3 Overall Brand Perceptions
Generate a dynamic, graphical display that allows the user to perform a calculation of the Overall Brand Perception in selected subgroups. Much like the previous question, the user may make any combination of selections in the following variables, provided that at least one category of each variable is selected: Age Group, Gender, Income Group, Region, Persona.

Also allow the user to select how many brands should be displayed, with the top k brands depicted in decreasing sorted order. All results should display the overall average perception for the brand.

### 4.Gaps in Outcomes
Create a dynamic, graphical display that ranks the products in terms of the difference in averages between any two selected outcomes. The user will be allowed to make the following selections:

First Outcome: One of the outcome variables.

Second Outcome: Another outcome variable.

The difference in rates will be Difference = Average First Outcome - Average Second Outcome per product.

Number of Top Products: The user will select how many products to display.

Display Percentages: If checked, the bargraph will display the percentages for each product.

Digits: How many digits should the percentages be rounded to? 1 digit would be a number like 84.2%.

### 5. Aggregated Engagement
Let’s allow the user to build a model including an aggregated outcome for a specific product. The site should include the following features:

The user can select the products (1 or more).

The user can select the state of engagement as the outcome.

The user can select the other variables to include in the model. The list of choices should include the age group, gender, income group, region, persona, brand perceptions, and the Aggregated Engagement. Each person’s aggregated engagement will be calculated as the average score of the selected state of engagement across the measured values of the other products . You can give this variable a name like “Aggregated.Engagement”.

The user’s selections will then be incorporated into a model. For Satisfaction outcomes, use a linear regression. For all of the other outcomes, use a logistic regression. Then create a dynamic table showing the model’s results. For logistic regressions, this must include the Odds Ratios, 95% confidence intervals for the Odds ratios, and the p-values. For linear regressions, this must include the coefficients, 95% confidence intervals for the coefficients, and the p-values.

## Part 4: Identifying opportunities.

This part of the report is directed externally to the client’s senior leadership and  help to determine the future direction of the project and the company’s contract with this client



## License

    Copyright [2022] [NING YANG]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

