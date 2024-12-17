# Task Manager with GetX

This project is a Task Manager application built using Flutter and GetX for state management. The application allows users to add, update, delete, and manage tasks efficiently. It also includes user authentication and profile management features.

## Table of Contents

- [Features](#features)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Dependencies](#dependencies)
- [Contributing](#contributing)

## Features

- **Task Management**: Add, update, delete, and view tasks.
- **User Authentication**: Sign up, log in, and log out.
- **Profile Management**: Update user profile information and profile picture.
- **State Management**: Efficient state management using GetX.
- **Responsive UI**: User-friendly and responsive design.

## Screenshots

<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/19bb551c-0d53-4d73-97fd-ca4d1d030343" alt="Sign In Page" width="200px" />
      <br /><b>Sign In Page</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/07708846-7b57-4d8e-a1bb-ff84622c1511" alt="Signup Page" width="200px" />
      <br /><b>Signup Page</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/15ec0c0a-1d54-433d-b153-e15ae3ba071b" alt="Reset Password Screen" width="200px" />
      <br /><b>Reset Password Screen</b>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/956b0211-ef1a-436d-80df-6265970571ee" alt="Update Profile" width="200px" />
      <br /><b>Update Profile</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/a432bf9a-d092-4fb1-8c1b-a633b3ae2499" alt="OTP Screen" width="200px" />
      <br /><b>OTP Screen</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/4e5da744-9d0d-4f56-bcac-81bfd26be367" alt="New Task List" width="200px" />
      <br /><b>New Task List</b>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/79abf067-29db-4351-8311-6b76108b113a" alt="Complete Task" width="200px" />
      <br /><b>Complete Task</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/6d1b42df-4262-420c-bcb0-e72a1155205c" alt="Cancelled Task" width="200px" />
      <br /><b>Cancelled Task</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/33422439-7040-47bc-9313-3df39abad232" alt="Add New Task" width="200px" />
      <br /><b>Add New Task</b>
    </td>
  </tr>
</table>

## Installation

To get started with this project, follow these steps:

1. **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/task-manager-with-getx.git
    cd task-manager-with-getx
    ```

2. **Install dependencies**:
    ```bash
    flutter pub get
    ```

3. **Run the application**:
    ```bash
    flutter run
    ```

## Usage

1. **Add New Task**: Navigate to the "Add New Task" screen, fill in the task details, and click "Add New Task".
2. **Update Task**: Tap on a task to update its status or details.
3. **Delete Task**: Swipe left on a task to delete it.
4. **User Authentication**: Use the sign-up and login screens to create an account or log in.
5. **Profile Management**: Update your profile information and profile picture from the profile screen.

## Project Structure

The project structure is organized as follows:



## Project Structure

The project structure is organized as follows:

```
lib/
├── data/
│   ├── models/
│   ├── services/
│   └── utils/
├── ui/
│   ├── controllers/
│   ├── screens/
│   └── widgets/
├── main.dart
```

- **data/models**: Contains data models.
- **data/services**: Contains network services and API calls.
- **data/utils**: Contains utility classes and constants.
- **ui/controllers**: Contains GetX controllers for state management.
- **ui/screens**: Contains the UI screens.
- **ui/widgets**: Contains reusable UI components.

## Dependencies

The project uses the following dependencies:

- **Flutter**: The framework for building the application.
- **GetX**: For state management, dependency injection, and route management.
- **Image Picker**: For selecting images from the gallery.
- **HTTP**: For making network requests.

To view the complete list of dependencies, refer to the `pubspec.yaml` file.

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Open a pull request.
