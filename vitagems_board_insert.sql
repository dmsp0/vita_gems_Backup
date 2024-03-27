use HRDB;

INSERT INTO announcement (noticeid, title, content, category, authorid, publishdate, img)
values 
	('1', '인사이동 안내', '3월19일부터 인사이동이 진행됩니다.', '인사', '2023DV003', '2024-03-19', null),
    ('2', '업무시간 변경안내', '3월20일부터 유연근무제가 시범실시됩니다.', '업무', '2023DV001', '2024-03-20', null),
    ('3', '회사창립일 기념이벤트안내', '3월23일 회사창립일 기념이벤트가 진행됩니다. 많은 참가 부탁드립니다.', '이벤트', '2023DV002', '2024-03-21', null),
    ('4', '인사평가 안내', '3월25일부터 인사평가가 실시됩니다. 인사평가기간동안 모든 사원들은 정시출근 부탁드립니다.', '인사', '2023DV001', '2024-03-21', null),
    ('5', '신규프로젝트팀 모집안내', '4월에 예정되어있는 신규프로젝트에 관심이 있는 분들은 3월말에 진행되는 신규 프로젝트 프로모션에 참가해주시길 바랍니다.', '업무', '2023DV002', '2024-03-22', null),
    ('6', '사내 복지관련 설문조사 이벤트안내', '금일부터 실시되는 사내 복지관련 설문조사에 많은 참여부탁드립니다. 설문조사에 참여하신 분들 중 일부에게 소정의 사은품이 증정됩니다.', '이벤트', '2023DV003', '2024-03-23', null);
    

select * from announcement;