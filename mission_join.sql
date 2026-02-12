-- 260211 데일리미션 rami
DROP VIEW IF EXISTS v_fromis; -- 뷰가 이미 존재하면 삭제
DROP TABLE IF EXISTS fromis_9;


-- 1. 테이블 생성 (fromis_9)
CREATE TABLE fromis_9 (
    member_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    birth_date TEXT NOT  NULL,
    position TEXT -- 포지션
);


-- 2. 데이터 추가 (fromis_9 5인)
INSERT INTO fromis_9 (member_id, name, birth_date, position) VALUES
(1, '송하영', '1997-09-29', '보컬'),
(2, '박지원', '1998-03-20', '메인보컬'),
(3, '이채영', '2000-05-14', '메인댄서'),
(4, '이나경', '2000-06-01', '보컬'),
(5, '백지헌', '2003-04-17', '막내');

SELECT
  member_id AS 번호,
  name AS 이름,
  birth_date AS 생년월일,
  position AS 포지션
FROM fromis_9
ORDER BY member_id;

SELECT * FROM fromis_9;


-- 3. 뷰(View) 생성 : 자주 쓰는 조회를 저장하는 것


CREATE VIEW v_fromis AS -- 가상 테이블 생성
SELECT
  member_id AS 번호,
  name AS 이름,
  birth_date AS 생년월일,
  position AS 포지션
FROM fromis_9;

SELECT * FROM v_fromis; -- 뷰 조회



-- 4. 집계함수
-- 포지션별 인원 수
SELECT position, COUNT(*) AS 인원수
FROM fromis_9
GROUP BY position;


-- 가장 어린 멤버
SELECT name, birth_date
FROM fromis_9
WHERE birth_date = (
    SELECT MAX(birth_date)
    FROM fromis_9
);


-- 가장 많은 멤버
SELECT name, birth_date
FROM fromis_9
WHERE birth_date = (
    SELECT MIN(birth_date)
    FROM fromis_9
);


-- SELECT name, MAX(birth_date)


-- 노래 테이블(Songs)
DROP TABLE IF EXISTS Songs;

CREATE TABLE Songs (
    song_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    duration INTEGER NOT NULL -- duration in seconds
);


-- 음반테이블(albums)
DROP TABLE IF EXISTS Albums;

CREATE TABLE Albums (
    album_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    release_date TEXT NOT NULL
);


-- 수록곡 테이블 (tracklist)
DROP TABLE IF EXISTS Tracklist;

CREATE TABLE Tracklist (
    album_id INTEGER,
    song_id INTEGER,
    track_no INTEGER,
    PRIMARY KEY (album_id, song_id),
    FOREIGN KEY (album_id) REFERENCES Albums(album_id),
    FOREIGN KEY (song_id) REFERENCES Songs(song_id)
);


-- 데이터 삽입 (Songs)
INSERT INTO Songs (song_id, title, duration) VALUES
(1, 'DM', 210),
(2, 'Stay This Way', 195),
(3, 'WE GO', 200);

-- 앨범(Albums)
INSERT INTO Albums (album_id, title, release_date) VALUES
(1, 'Midnight Guest', '2022'),
(2, 'from our Memento Box', '2022');


-- 수록곡 (Tracklist)
INSERT INTO Tracklist VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1);


-- INNER JOIN 예제. 
-- 앨범 + 노래 연결
SELECT 
    a.title AS 앨범제목,
    t.track_no AS 트랙번호,
    s.title AS 노래제목,
    s.duration AS 재생시간
FROM Tracklist t
JOIN Albums a ON t.album_id = a.album_id
JOIN Songs s ON t.song_id = s.song_id
ORDER BY a.album_id, t.track_no;

-- WHERE 추가 
-- 2022년 발매 앨범만
SELECT 
    a.title
FROM Tracklist t
INNER JOIN Albums a ON t.album_id = a.album_id
INNER JOIN Songs s ON t.song_id = s.song_id
WHERE a.release_date = '2022';


-- 집계 + JOIN
-- 앨범별 수록곡 수
SELECT 
    a.title,
    COUNT(s.song_id) AS 수록곡수
FROM Albums a
LEFT JOIN Tracklist t ON a.album_id = t.album_id
LEFT JOIN Songs s ON t.song_id = s.song_id
GROUP BY a.title;
