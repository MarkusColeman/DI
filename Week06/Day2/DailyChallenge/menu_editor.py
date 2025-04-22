from menu_item import MenuItem
from menu_manager import MenuManager

def show_user_menu():
    while True:
        print("Program Menu:")
        print("V - View an Item")
        print("A - Add an Item")
        print("D - Delete an Item")
        print("U - Update an Item")
        print("S - Show the Restaurant Menu")
        print("Q - Quit")

        choice = input("Select an option: ").strip().upper()

        if choice == "V":
            name = input("Enter the name of the item to view: ")
            item = MenuManager.get_by_name(name)
            if item:
                print(f"{item.name} (${item.price})")
            else:
                print("Item not found.")
        elif choice == "A":
            add_item_to_menu()
        elif choice == "D":
            remove_item_from_menu()
        elif choice == "U":
            update_item_from_menu()
        elif choice == "S":
            show_restaurant_menu()
        elif choice == "Q":
            show_restaurant_menu()
            break
        else:
            print("Invalid option.")

def add_item_to_menu():
    name = input("Enter item name: ")
    price = input("Enter item price: ")
    try:
        item = MenuItem(name, int(price))
        item.save()
        print("Item was added successfully.")
    except Exception:
        print("There was an error adding the item.")

def remove_item_from_menu():
    name = input("Enter the name of the item to remove: ")
    item = MenuManager.get_by_name(name)
    if item:
        try:
            item.delete()
            print("Item was deleted successfully.")
        except Exception:
            print("There was an error deleting the item.")
    else:
        print("Item not found.")

def update_item_from_menu():
    old_name = input("Enter the name of the item to update: ")
    old_price = input("Enter the current price of the item: ")
    new_name = input("Enter the new name: ")
    new_price = input("Enter the new price: ")

    try:
        item = MenuItem(old_name, int(old_price))
        item.update(new_name, int(new_price))
        print("Item was updated successfully.")
    except Exception:
        print("There was an error updating the item.")

def show_restaurant_menu():
    items = MenuManager.all_items()
    if not items:
        print("No items found.")
    else:
        print("Restaurant Menu:")
        for i in items:
            print(f"- {i.name} (${i.price})")

if __name__ == "__main__":
    show_user_menu()
