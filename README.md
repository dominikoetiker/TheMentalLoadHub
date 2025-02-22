# The Mental Load Hub

**The Mental Load Hub** is a household organization application designed to simplify daily life for any shared living
arrangement. The app provides a centralized platform for managing tasks, projects, shopping lists, and custom lists,
enabling household members to collaborate efficiently and reduce organizational overhead.

## About the Project

For details on project planning and the current status,
see: [The Mental Load Hub - GitHub Projects](https://github.com/users/dominikoetiker/projects/1)

The goal of The Mental Load Hub is to streamline household management by offering features that help users:

- Organize and assign daily tasks with priorities and deadlines.
- Manage recurring chores and one-time tasks through visual status tracking and Kanban boards.
- Create and maintain shopping lists with real-time synchronization.
- Define areas of responsibility to clearly allocate household duties.
- Manage complex projects by breaking them into manageable tasks and setting clear goals.
- Enhance data entry with auto-completion suggestions for frequently used items.
- Stay informed with customizable reminders and notifications.
- Adapt the interface to multiple languages and regional settings.

This project is currently in development. The repository will evolve as new features are implemented and the overall
design is refined based on feedback and testing.

## Planned Tech Stack

- **Database:** MariaDB
- **Backend:** Python with Flask
- **Frontend:** TypeScript with React
- **Mobile:** React Native

## Draft the app (Diagrams)

- [x] ERD: [TheMentalLoadHub_ERD.svg](docs/diagrams/erd/TheMentalLoadHub_ERD.png)
- [x] Database Schema: [database_schema.sql](docs/database/database_schema.sql)
- [x] Use Case Diagram: [use_case.svg](docs/diagrams/uml/use_case/use_case.svg)
- [ ] **Class Diagram for backend**
    - [x] Model Classes: [class-0.svg](docs/diagrams/uml/class/class-0.svg)
    - [x] Model Relations: [class-1.svg](docs/diagrams/uml/class/class-1.svg)
    - [ ] Service Classes: [class-2.svg](docs/diagrams/uml/class/class-2.svg)
- [ ] **Sequence Diagrams**
    - [ ] **Account management**
        - [x] Sign up (#23): [sign_up-0.svg](docs/diagrams/uml/sequence/sign_up-0.svg)
        - [x] Email verification (#23, 27): [email-verification-0.svg](docs/diagrams/uml/sequence/email-verification-0.svg)
        - [ ] Authentication process
            - [x] Create JWT: [create_jwt-0.svg](docs/diagrams/uml/sequence/create_jwt-0.svg)
            - [x] Revoke JWT: [revoke_jwt-0.svg](docs/diagrams/uml/sequence/revoke_jwt-0.svg)
            - [ ] Refresh JWT:
            - [ ] Verify JWT:
            - [x] Login (#25): [login-0.svg](docs/diagrams/uml/sequence/login-0.svg)
            - [ ] Logout (#26):
        - [ ] Update account (#24, #27)
        - [ ] Reset password (#28)
        - [ ] Delete account
    - [ ] **Household management**
        - [ ] Create household (#12, #13)
        - [ ] Update household (#16)
        - [ ] Delete household (#15)
        - [ ] Add member (#18)
        - [ ] Remove member (#19)
        - [ ] Assign admin role (#20)
        - [ ] Remove admin role
        - [ ] View household members (#30)
    - [ ] **Task management**
        -[ ] Create recurring task (#34, #35, #38, #39)
        -[ ] Create non recurring task (#34, #35, #41)
        -[ ] Update recurring task (#38, #39, #40, #45, #46, #47)
        -[ ] Update non recurring task (#41, #45, #47)

## License

This project is licensed under the MIT License.