                                # Example 1 : Selecting Random N Rows

install.packages('dplyr')
library(dplyr)

sample_n(mtcars,3)  #  3 random rows from mtcars



                              # Example 2 : Selecting Random Fraction of Rows

sample_frac(mtcars,0.5)   # 50% rows from mtcars

                              # Example 3 : Remove Duplicate Rows 


distinct(mtcars) # for complete row 


distinct(mtcars,cyl,.keep_all=T)  # row based on variable(cyl) 
distinct(mtcars,cyl,gear,.keep_all=T)  # row based on multipl_variable(cyl and gear) 
                         
                             # Example 4 : Select variables or Drop variables

select(mtcars,cyl,gear)   #select 2 variables

select(mtcars,cyl:gear)   #select from cyl to gear

select(mtcars,-cyl)      #Drop cyl


select(mtcars,starts_with('c'))    #Select variables starting with 'c'

select(mtcars,contains('c'))    #Select variables containing  'c'

select(mtcars,cyl,everything())       #Reorder Variables starting from 'cyl'


                              # Example 5:  Rename


rename(mtcars,cyyl=cyl)    # Rename 'cyl' with 'cyyl'


                            #  Example 6: Filter


filter(mtcars,gear==4)  # filter DF where gear=4

filter(mtcars, gear %in% c(4,3))  #filter multiple values in a varibale

filter(mtcars, gear %in% c(4,3)&carb>=3)  # AND 

filter(mtcars, gear %in% c(4,3) | carb>=3)  # OR

filter(mtcars, !gear %in% c(4,3)&carb>=3)   # NOT

filter(mtcars,grepl('30',disp))           # Contain Condition

                                
                              #Example 7: summarise( ) Function


summarise(mtcars,mean_disp = mean(disp),mean_drat=mean(drat))  # mean of variables

summarise_at(mtcars,vars(disp,hp),list(~n(),~mean(.),~median(.))) #multiple operators on mult. vars.














