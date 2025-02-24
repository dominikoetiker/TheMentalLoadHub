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

- [x] ERD: [TheMentalLoadHub_ERD.svg](docs/out/diagrams/erd/TheMentalLoadHub_ERD.svg)
- [x] Database Schema: [database_schema.sql](docs/src/database/database_schema.sql)
- [x] Use Case Diagram: [TheMentalLoadHubUseCases.svg](docs/out/diagrams/uml/use_case/TheMentalLoadHubUseCases.svg)
- [ ] **Class Diagram for backend**
  - [x] Model Classes: [BackendClasses-page1.svg](docs/out/diagrams/uml/class/BackendClasses-page1.svg)
  - [x] Model Relations: [BackendClasses-page2.svg](docs/out/diagrams/uml/class/BackendClasses-page2.svg)
  - [ ] Service Classes: [BackendClasses-page3.svg](docs/out/diagrams/uml/class/BackendClasses-page3.svg)
- [ ] **Sequence Diagrams**
  - [ ] **Account management**
    - [x] Sign up (#23): [SignUpSequence.svg](docs/out/diagrams/uml/sequence/account_management/SignUpSequence.svg)
    - [x] Email verification (#23, 27): [EmailVerificationSequence.svg](docs/out/diagrams/uml/sequence/account_management/EmailVerificationSequence.svg)
    - [x] **Authentication process**
      - [x] Create JWT: [CreateJWTSequence.svg](docs/out/diagrams/uml/sequence/account_management/authentication_process/CreateJWTSequence.svg)
      - [x] Revoke JWT: [RevokeJWTSequence.svg](docs/out/diagrams/uml/sequence/account_management/authentication_process/RevokeJWTSequence.svg)
      - [x] Refresh JWT: [RefreshJWTSequence.svg](docs/out/diagrams/uml/sequence/account_management/authentication_process/RefreshJWTSequence.svg)
      - [x] Verify JWT: [VerifyJWTSequence.svg](docs/out/diagrams/uml/sequence/account_management/authentication_process/VerifyJWTSequence.svg)
      - [x] Login (#25): [LoginSequence.svg](docs/out/diagrams/uml/sequence/account_management/authentication_process/LoginSequence.svg)
      - [x] Logout (#26): [LogoutSequence.svg](docs/out/diagrams/uml/sequence/account_management/authentication_process/LogoutSequence.svg)
    - [x] Update account (#24, #27) [UpdateAccountSequence.svg](docs/out/diagrams/uml/sequence/account_management/UpdateAccountSequence.svg)
    - [x] Reset password generate link (#28) [ResetPasswordSequence.svg](docs/out/diagrams/uml/sequence/account_management/ResetPasswordSequence.svg)
    - [ ] Reset password use link (#28)
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
  - [ ] **Task management** -[ ] Create recurring task (#34, #35, #38, #39) -[ ] Create non recurring task (#34, #35, #41) -[ ] Update recurring task (#38, #39, #40, #45, #46, #47) -[ ] Update non recurring task (#41, #45, #47)

## License

This project is licensed under the MIT License.
