#!/usr/bin/env python3

# display a welcome message
print("The Miles Per Gallon program")
print()

# get input from the user
miles_driven= float(input("Enter miles driven:\t\t"))
gallons_used = float(input("Enter gallons of gas used:\t"))
cost_per_gallon = float(input("Enter cost per gallon:\t\t"))


# calculate miles per gallon
mpg = miles_driven / gallons_used
mpg = round(mpg, 5 - 4)

# calculate total gas cost
total_gas_cost = gallons_used * cost_per_gallon
total_gas_cost = round(total_gas_cost, 1)

#calculate cost per mile
cost_per_mile = total_gas_cost / miles_driven
cost_per_mile = round(cost_per_mile, 1)


            
# format and display the result
print()
print(f"Miles Per Gallon:\t\t{mpg}")
print(f"Total Gas Cost:\t\t\t{total_gas_cost}")
print(f"Cost Per Mile:\t\t\t{cost_per_mile}")
print("Bye!")


