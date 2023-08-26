#!/usr/bin/env python3
        

def get_int(prompt, high_val = 50, low_val = 0):
    err_msg = f"Entry must be greater than {low_val} and less than or equal to {high_val}"
    val = int(input(prompt))
    while val <= low_val or val > high_val:
        print(err_msg)
        val = int(input(prompt))
    return val;
    
    
def get_float(prompt, high_val = 1000, low_val = 0):
    err_msg_1 = f"Entry must be greater than {low_val} and less than or equal to {high_val}"
    err_msg_2 = f"Entry must be greater than {low_val} and less than or equal to {high_val}"

    
    if prompt == "Enter monthly investment:\t\t":
        val = float(input(prompt))
        while val <= low_val or val > high_val:
            print(err_msg_1)
            val = float(input(prompt))
        
    elif prompt == "Enter yearly interest rate:\t\t":
        val = float(input(prompt))
        while val <= low_val or val > high_val:
            print(err_msg_2)
            val = float(input(prompt))
    return val
    
def main():
    get_int() # test get int
    get_float() # test get float
if __name__ == "__main__":
    main()
