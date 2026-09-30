create table admin
(
    username varchar(50)  not null
        primary key,
    password varchar(100) not null
);

create table student
(
    rollno     bigint                                        not null
        primary key,
    name       varchar(100)                                  not null,
    fathername varchar(100)                                  not null,
    mothername varchar(100)                                  not null,
    dob        date                                          not null,
    semester   int                                           not null,
    year       int                                           not null,
    course     varchar(100) default 'Bachelor Of Technology' not null,
    check (`semester` between 1 and 8)
);

create table subject
(
    subjectcode varchar(20)  not null
        primary key,
    subjectname varchar(100) not null
);

create table marks
(
    rollno      bigint      not null,
    subjectcode varchar(20) not null,
    marks       int         not null,
    primary key (rollno, subjectcode),
    constraint marks_ibfk_1
        foreign key (rollno) references student (rollno)
            on delete cascade,
    constraint marks_ibfk_2
        foreign key (subjectcode) references subject (subjectcode)
            on delete cascade,
    check (`marks` between 0 and 100)
);

create index subjectcode
    on marks (subjectcode);
