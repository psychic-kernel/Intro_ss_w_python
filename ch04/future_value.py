#!/usr/bin/env python3
        
def calculate_future_value(monthly_investment, yearly_interest, years):
    # convert yearly values to monthly values
    monthly_interest_rate = yearly_interest / 12 / 100
    months = years * 12

    # calculate future value
    future_value = 0.0
    for i in range(months):
        future_value += monthly_investment
        monthly_interest = future_value * monthly_interest_rate
        future_value += monthly_interest

    return future_value
    
def main():
    import validation
    choice = "y"
    while choice.lower() == "y":
        # get input from the user'
        prompt_1 = "Enter monthly investment:\t\t"
        prompt_2 = "Enter yearly interest rate:\t\t"
        prompt_3 = "Enter number of years:\t\t"
        
        monthly_investment = validation.get_float(prompt_1)
        yearly_interest_rate = validation.get_float(prompt_2, 15, 0)
        years = validation.get_int(prompt_3)
        
        # get and display future value
        future_value = calculate_future_value(
            monthly_investment, yearly_interest_rate, years)

        print(f"Future value:\t\t\t{round(future_value, 2)}")
        print()
        
    
        choice = input("Continue? y/n")
    print()
    print("Bye!")
if __name__ == "__main__": 
    main()
