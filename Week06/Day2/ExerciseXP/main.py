from menu_item import MenuItem
from menu_manager import MenuManager

def show_menu():
    print("Menu Items:")
    items = MenuManager.all_items()
    if not items:
        print("No items found.")
    else:
        for i in items:
            print(f"- {i.name} (${i.price})")

def add_item():
    name = input("Enter new item name: ")
    price = input("Enter item price: ")
    try:
        item = MenuItem(name, int(price))
        item.save()
        print(f"Item '{item.name}' added with price ${item.price}.")
    except ValueError:
        print("Price must be a number.")

def delete_item():
    name = input("Enter the name of the item to delete: ")
    item = MenuManager.get_by_name(name)
    if item:
        item.delete()
        print(f"Item '{name}' has been deleted.")
    else:
        print("Item not found.")

if __name__ == "__main__":
    print("Restaurant Menu Manager")
    print("1. View menu")
    print("2. Add new item")
    print("3. Delete item")
    choice = input("Select an option (1-3): ")

    if choice == "1":
        show_menu()
    elif choice == "2":
        add_item()
    elif choice == "3":
        delete_item()
    else:
        print("Invalid option.")
