# lab-06  

**Create basic views for your models**

In this evaluation, you will add basic views to your Whats New application using Ruby on Rails.

---

## Instructions

Work on the same repository as the last laboratory session so you can have the code you already generated for the models.

### 1. Create views for your models

Using the models created in **lab-05**, you will now implement the basic **index** and **show** views for each one.

You must create views for the following models:

- `User`
- `Chat`
- `Message`

---

### 1.1 Index views

For each model, create an `index` view that:

- Lists all the records of the model
- Shows the values of all attributes in a table format
- Includes a link to see each individual record (`show` view)

---

### 1.2 Show views

For each model, create a `show` view that:

- Displays all the attribute values of a single instance
- Includes a link to go back to the index view

> 💡 Example: In `app/views/users/show.html.erb`, display the full name and email of the user.

---

You can use plain HTML and embedded Ruby (`.html.erb`). You are not expected to use CSS or any frontend framework at this point.

### 2. Add a navigation bar

Using Bootstrap add a navigation bar at the top of the page. This should be displayed in all pages of the app, for this you should use rails partials (https://guides.rubyonrails.org/layouts_and_rendering.html#using-partials)