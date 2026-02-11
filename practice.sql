-- 1. [테이블 생성] 학생 정보를 담을 상자 만들기
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    major TEXT
);

-- 2. [데이터 추가] 내 정보 한 줄 넣기
INSERT INTO students (student_id, name, major) 
VALUES (1, '신아람', '데이터공학');

-- 3. [데이터 조회] 상자 안에 뭐가 들었나 확인하기
SELECT * FROM students;

-- 4. [데이터 수정] 전공을 'AI개발'로 변경하기
UPDATE students SET major = 'AI개발' WHERE student_id = 1;

-- 5. [데이터 삭제] 데이터 지우기 (연습용)
-- DELETE FROM students WHERE student_id = 1;

-- 6. 최종 확인
SELECT * FROM students;