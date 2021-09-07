## Grocery Store Challenge

Consider a supermarket like Big Bazaar where they sell items by quantity and if a customer purchases more quantities, then the discounts will be applied to some items. 

This week the pricing table at the local grocery store looks like this.

```
Item                      Unit price        Discounted price
————————————————————————————————————————————————————————————
Bread                     Rs. 60            3 for Rs. 150
Eggs                      Rs. 40            2 for Rs. 70
Milk                      Rs. 60
Tea                       Rs. 150
```

At the billing counter, the items are accepted in any order. For example, the order can be Eggs, Milk, Tea, Eggs, Eggs. Over here, the quantity of eggs is 3 and so the total price for eggs is calculated as follows: 
1. For the first two eggs, the price would be Rs.70
2. For the 3rd egg, the price would be Rs 40.
So, the total price for eggs would be Rs. 110.

Build a ruby program which will take input as the items separated by a comma and will calculate and print the total price and savings.

Sample input string: Eggs,eggs,bread,milk,tea,bread,bread,bread,milk


### Task

Task is to build a ruby program which when executed would ask user to list all the items purchased in any order. 
Once user has listed all the items then print the total cost. 

You need to build solution for the given items and you do not need to worry about items which would be added in future -- in other words the pricing table is static.

``` 
$ ruby price_calculator.rb

Item               Quantity       Price
-------------------------------------------
Bread                  4              Rs. 210
Eggs                   2              Rs. 70
Milk                   2              Rs. 120
Tea                    1              Rs. 150

Total price : Rs. 550
Savings: Rs. 40

```

### Run solution using below command:
```
 $ ruby invoice.rb 
```

### Note
Please install terminal-table using below command before running the solution
```
$ gem install terminal-table
```


