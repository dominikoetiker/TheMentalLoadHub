DROP TRIGGER IF EXISTS delete_task_at_project_delete;
DROP TRIGGER IF EXISTS insert_child_table_record_at_task_insert;
DROP TRIGGER IF EXISTS update_task_done_at;
DROP TRIGGER IF EXISTS update_project_done_at;
DROP TABLE IF EXISTS ShoppingList_ShoppingListItem;
DROP TABLE IF EXISTS ShoppingListItem;
DROP TABLE IF EXISTS ShoppingListItemCategory;
DROP TABLE IF EXISTS ShoppingList;
DROP TABLE IF EXISTS Task_TaskHelper;
DROP TABLE IF EXISTS NonRecurringTask;
DROP TABLE IF EXISTS RecurringTask;
DROP TABLE IF EXISTS Task;
DROP TABLE IF EXISTS CustomList_CustomListItem;
DROP TABLE IF EXISTS CustomListItem;
DROP TABLE IF EXISTS CustomList;
DROP TABLE IF EXISTS User_Project;
DROP TABLE IF EXISTS ProjectGoal;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS AreaOfResponsibility;
DROP TABLE IF EXISTS Household_User;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Household;


CREATE TABLE Household
(
    household_id INT AUTO_INCREMENT,
    name         VARCHAR(255) NOT NULL,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (household_id)
);

CREATE TABLE User
(
    user_id         INT AUTO_INCREMENT,
    email           VARCHAR(255) NOT NULL,
    hashed_password VARCHAR(255) NOT NULL,
    is_active       BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMP             DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP             DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id),
    UNIQUE (email)
);

CREATE TABLE Household_User
(
    household_user_id INT AUTO_INCREMENT,
    user_id           INT                            NOT NULL,
    household_id      INT                            NOT NULL,
    household_role    ENUM ('Administrator', 'User') NOT NULL,
    is_accepted       BOOLEAN                        NOT NULL DEFAULT FALSE,
    is_deleted        BOOLEAN                        NOT NULL DEFAULT FALSE,
    PRIMARY KEY (household_user_id),
    FOREIGN KEY (user_id) REFERENCES User (user_id) ON DELETE CASCADE,
    FOREIGN KEY (household_id) REFERENCES Household (household_id) ON DELETE CASCADE,
    UNIQUE (user_id, household_id)
);

CREATE TABLE AreaOfResponsibility
(
    area_of_responsibility_id INT AUTO_INCREMENT,
    household_id              INT          NOT NULL,
    assigned_to               INT,
    title                     VARCHAR(255) NOT NULL,
    description               TEXT,
    created_at                TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (area_of_responsibility_id),
    FOREIGN KEY (household_id) REFERENCES Household (household_id) ON DELETE CASCADE,
    FOREIGN KEY (assigned_to) REFERENCES User (user_id) ON DELETE SET NULL
);

CREATE TABLE Project
(
    project_id                INT AUTO_INCREMENT,
    household_id              INT          NOT NULL,
    created_by                INT          NOT NULL,
    area_of_responsibility_id INT,
    title                     VARCHAR(255) NOT NULL,
    description               TEXT,
    deadline                  DATE,
    is_done                   BOOLEAN   DEFAULT FALSE,
    created_at                TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    done_at                   DATETIME,
    PRIMARY KEY (project_id),
    FOREIGN KEY (household_id) REFERENCES Household (household_id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES User (user_id) ON DELETE CASCADE,
    FOREIGN KEY (area_of_responsibility_id) REFERENCES AreaOfResponsibility (area_of_responsibility_id) ON DELETE SET NULL
);

CREATE TABLE ProjectGoal
(
    goal_id     INT AUTO_INCREMENT,
    project_id  INT          NOT NULL,
    title       VARCHAR(255) NOT NULL,
    description TEXT,
    PRIMARY KEY (goal_id),
    FOREIGN KEY (project_id) REFERENCES Project (project_id) ON DELETE CASCADE
);

CREATE TABLE User_Project
(
    user_project_id INT AUTO_INCREMENT,
    user_id         INT NOT NULL,
    project_id      INT NOT NULL,
    project_role    ENUM ('Project Manager', 'Contributor'),
    PRIMARY KEY (user_project_id),
    FOREIGN KEY (user_id) REFERENCES User (user_id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES Project (project_id) ON DELETE CASCADE
);

CREATE TABLE CustomList
(
    custom_list_id            INT AUTO_INCREMENT,
    household_id              INT,
    created_by                INT          NOT NULL,
    area_of_responsibility_id INT,
    project_id                INT,
    title                     VARCHAR(255) NOT NULL,
    description               TEXT,
    is_checklist              BOOLEAN   DEFAULT FALSE,
    is_active                 BOOLEAN   DEFAULT TRUE,
    created_at                TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (custom_list_id),
    FOREIGN KEY (household_id) REFERENCES Household (household_id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES User (user_id) ON DELETE CASCADE,
    FOREIGN KEY (area_of_responsibility_id) REFERENCES AreaOfResponsibility (area_of_responsibility_id) ON DELETE SET NULL,
    FOREIGN KEY (project_id) REFERENCES Project (project_id) ON DELETE CASCADE
);

CREATE TABLE CustomListItem
(
    custom_list_item_id INT AUTO_INCREMENT,
    household_id        INT          NOT NULL,
    name                VARCHAR(255) NOT NULL,
    PRIMARY KEY (custom_list_item_id),
    FOREIGN KEY (household_id) REFERENCES Household (household_id) ON DELETE CASCADE,
    UNIQUE (household_id, name)
);

CREATE TABLE CustomList_CustomListItem
(
    custom_list_custom_list_item_id INT AUTO_INCREMENT,
    custom_list_id                  INT NOT NULL,
    custom_list_item_id             INT NOT NULL,
    parent_item                     INT,
    quantity                        FLOAT,
    unit                            VARCHAR(10),
    note                            VARCHAR(255),
    is_done                         BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (custom_list_custom_list_item_id),
    FOREIGN KEY (custom_list_id) REFERENCES CustomList (custom_list_id) ON DELETE CASCADE,
    FOREIGN KEY (custom_list_item_id) REFERENCES CustomListItem (custom_list_item_id) ON DELETE CASCADE,
    FOREIGN KEY (parent_item) REFERENCES CustomList_CustomListItem (custom_list_custom_list_item_id) ON DELETE SET NULL
);

CREATE TABLE Task
(
    task_id                   INT AUTO_INCREMENT,
    household_id              INT,
    created_by                INT                                              NOT NULL,
    assigned_to               INT,
    area_of_responsibility_id INT,
    priority                  ENUM ('Urgent', 'High', 'Medium', 'Low'),
    status                    ENUM ('Backlog', 'To Do', 'In Progress', 'Done') NOT NULL,
    is_recurring              BOOLEAN                                          NOT NULL DEFAULT FALSE,
    title                     VARCHAR(255)                                     NOT NULL,
    description               TEXT,
    created_at                TIMESTAMP                                                 DEFAULT CURRENT_TIMESTAMP,
    updated_at                TIMESTAMP                                                 DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    done_at                   DATETIME,
    PRIMARY KEY (task_id),
    FOREIGN KEY (household_id) REFERENCES Household (household_id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES User (user_id) ON DELETE CASCADE,
    FOREIGN KEY (assigned_to) REFERENCES User (user_id) ON DELETE SET NULL,
    FOREIGN KEY (area_of_responsibility_id) REFERENCES AreaOfResponsibility (area_of_responsibility_id) ON DELETE SET NULL
);

CREATE TABLE RecurringTask
(
    task_id             INT,
    recurrence_cycle    ENUM ('daily', 'weekly','monthly', 'yearly') NOT NULL DEFAULT 1,
    recurrence_interval INT                                          NOT NULL DEFAULT 1,
    next_reset_at       DATETIME                                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_active           BOOLEAN                                      NOT NULL DEFAULT TRUE,
    PRIMARY KEY (task_id),
    FOREIGN KEY (task_id) REFERENCES Task (task_id) ON DELETE CASCADE
);

CREATE TABLE NonRecurringTask
(
    task_id    INT,
    project_id INT,
    deadline   DATETIME,
    PRIMARY KEY (task_id),
    FOREIGN KEY (task_id) REFERENCES Task (task_id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES Project (project_id)
);

CREATE TABLE Task_TaskHelper
(
    task_task_helper_id INT AUTO_INCREMENT,
    task_id             INT NOT NULL,
    user_id             INT NOT NULL,
    PRIMARY KEY (task_task_helper_id),
    FOREIGN KEY (task_id) REFERENCES Task (task_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES USER (user_id) ON DELETE CASCADE
);

CREATE TABLE ShoppingList
(
    shopping_list_id          INT AUTO_INCREMENT,
    household_id              INT,
    created_by                INT          NOT NULL,
    area_of_responsibility_id INT,
    project_id                INT,
    title                     VARCHAR(255) NOT NULL,
    created_at                TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (shopping_list_id),
    FOREIGN KEY (household_id) REFERENCES Household (household_id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES User (user_id) ON DELETE CASCADE,
    FOREIGN KEY (area_of_responsibility_id) REFERENCES AreaOfResponsibility (area_of_responsibility_id) ON DELETE SET NULL,
    FOREIGN KEY (project_id) REFERENCES Project (project_id) ON DELETE CASCADE
);

CREATE TABLE ShoppingListItemCategory
(
    shopping_list_item_category_id INT AUTO_INCREMENT,
    household_id                   INT          NOT NULL,
    title                          VARCHAR(255) NOT NULL,
    PRIMARY KEY (shopping_list_item_category_id),
    FOREIGN KEY (household_id) REFERENCES Household (household_id) ON DELETE CASCADE,
    UNIQUE (household_id, title)
);

CREATE TABLE ShoppingListItem
(
    shopping_list_item_id INT AUTO_INCREMENT,
    category_id           INT,
    household_id          INT          NOT NULL,
    title                 VARCHAR(255) NOT NULL,
    PRIMARY KEY (shopping_list_item_id),
    FOREIGN KEY (category_id) REFERENCES ShoppingListItemCategory (shopping_list_item_category_id) ON DELETE SET NULL,
    FOREIGN KEY (household_id) REFERENCES Household (household_id) ON DELETE CASCADE,
    UNIQUE (household_id, title)
);

CREATE TABLE ShoppingList_ShoppingListItem
(
    shopping_list_shopping_list_item INT AUTO_INCREMENT,
    shopping_list_item_id            INT NOT NULL,
    shopping_list_id                 INT NOT NULL,
    quantity                         FLOAT,
    unit                             VARCHAR(10),
    note                             VARCHAR(255),
    is_done                          BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (shopping_list_shopping_list_item),
    FOREIGN KEY (shopping_list_item_id) REFERENCES ShoppingListItem (shopping_list_item_id) ON DELETE CASCADE,
    FOREIGN KEY (shopping_list_id) REFERENCES ShoppingList (shopping_list_id) ON DELETE CASCADE
);

/*
Set a done timestamps for projects and tasks when they are done
*/

DELIMITER //
CREATE TRIGGER update_project_done_at
    BEFORE UPDATE
    ON Project
    FOR EACH ROW
BEGIN
    IF NEW.is_done = TRUE AND OLD.is_done = FALSE THEN
        SET NEW.done_at = CURRENT_TIMESTAMP;
    ELSEIF NEW.is_done = FALSE AND OLD.is_done = TRUE THEN
        SET NEW.done_at = NULL;
    END IF;
END;
//
DELIMITER  ;

DELIMITER //
CREATE TRIGGER update_task_done_at
    BEFORE UPDATE
    ON Task
    FOR EACH ROW
BEGIN
    IF NEW.status = 4 AND OLD.status != 4 THEN
        SET new.done_at = CURRENT_TIMESTAMP;
    ELSEIF new.status != 4 AND old.status = 4 THEN
        SET new.done_at = NULL;
    END IF;
END;
//
DELIMITER ;

/*
Enforce the rule, that each task needs to have either a NonRecurringTask entry or a RecurringTask entry
*/

DELIMITER //
CREATE TRIGGER insert_child_table_record_at_task_insert
    AFTER INSERT
    ON Task
    FOR EACH ROW
BEGIN
    IF NEW.is_recurring = TRUE THEN
        INSERT INTO RecurringTask (task_id) VALUES (NEW.task_id);
    ELSE
        INSERT INTO NonRecurringTask (task_id) VALUES (NEW.task_id);
    END IF;
END;
//
DELIMITER ;

/*
Delete a task, when the corresponding project gets deleted
*/

DELIMITER //
CREATE TRIGGER delete_task_at_project_delete
    AFTER DELETE
    ON NonRecurringTask
    FOR EACH ROW
BEGIN
    DELETE
    FROM Task
    WHERE task_id = OLD.task_id;
END;
//
DELIMITER ;