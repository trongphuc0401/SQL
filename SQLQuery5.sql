--Dinh dang ngay thang nam
set dateformat dmy

--Tao database
create database db_bt35

--Chon database hien hanh
use db_bt35

--Tao table cho cac bang
create table khoa
(
	makh	varchar(2)		not null primary key,
	tenkh	nvarchar(50)	not null
)

create table monhoc
(
	mamh	varchar(2)		not null primary key,
	tenmh	nvarchar(50)	not null,
	sotiet	int				not null check (sotiet >=30)
) 

create table sinhvien
(
	masv		varchar(3)		not null primary key,
	hosv		nvarchar(50)	not null,
	tensv		nvarchar(50)	not null,
	phai		bit				not null,
	ngaysinh	datetime		not null,
	noisinh		nvarchar(50)	not null,
	makh		varchar(2)		not null,
	hocbong		int
)
alter table sinhvien add constraint fk_sv_kh foreign key (makh) references khoa (makh)

create table ketqua
(
	masv		varchar(3)	not null,
	mamh		varchar(2)	not null,
	diem		real		not null check(diem between 0 and 10)
)
alter table ketqua add constraint pk_kq primary key (masv, mamh)
alter table ketqua add constraint fk_kq_sv foreign key (masv) references sinhvien (masv)
alter table ketqua add constraint fk_kq_mh foreign key (mamh) references monhoc (mamh)

--Chen dl
insert into khoa values ('AV',N'Anh Văn')
insert into khoa values ('LS',N'Lịch sử')
insert into khoa values ('TH',N'Tin học')
insert into khoa values ('TR',N'Triết')
insert into khoa values ('VL',N'Vật lý')
insert into khoa values ('SH',N'Sinh học')
select * from khoa

insert into sinhvien values
	('A01',N'Nguyễn Thu',N'Hải',0,'23/02/1980',N'TP.HCM','AV',100000)
insert into sinhvien values('A02',N'Trần Văn',N'Chính',1,'24/12/1982',N'TP.HCM','TH',100000)
insert into sinhvien values('A03',N'Lê Thu Bạch',N'Yến',0,'21/02/1982',N'Hà Nội','AV',140000)
insert into sinhvien values('A04',N'Trần Anh',N'Tuấn',1,'08/12/1984',N'Long An','LS',80000)
insert into sinhvien values('A05',N'Trần Thanh',N'Triều',1,'01/02/1980',N'Hà Nội','VL',80000)
insert into sinhvien values('B01',N'Trần Thanh',N'Mai',0,'20/12/1981',N'Bến Tre','TH',200000)
insert into sinhvien values('B02',N'Trần Thị Thu',N'Thủy',0,'13/02/1982',N'TP.HCM','TH',30000)
insert into sinhvien values('B03',N'Trần Thị',N'Thanh',0,'31/12/1982',N'TP.HCM','TH',50000)
select * from sinhvien

insert into monhoc values ('01',N'Nhập môn máy tính',30)
insert into monhoc values ('02',N'Trí tuệ nhân tạo',45)
insert into monhoc values ('03',N'Truyền tin',45)
insert into monhoc values ('04',N'Đồ họa',50)
insert into monhoc values ('05',N'Văn phạm',40)
insert into monhoc values ('06',N'Đàm thoại',30)
insert into monhoc values ('07',N'Vật lý nguyên tử',30)
select * from monhoc

insert into ketqua values('A01','01',10)
insert into ketqua values('A01','02',4)
insert into ketqua values('A01','05',9)
insert into ketqua values('A01','06',3)
insert into ketqua values('A02','01',5)
insert into ketqua values('A03','02',5)
insert into ketqua values('A03','04',10)
insert into ketqua values('A03','06',1)
insert into ketqua values('A04','02',4)
insert into ketqua values('A04','04',6)
insert into ketqua values('B01','01',0)
insert into ketqua values('B01','04',8)
insert into ketqua values('B02','03',6)
insert into ketqua values('B02','04',8)
insert into ketqua values('B03','02',10)
insert into ketqua values('B03','03',9)
select * from ketqua
---------------
select * from khoa
select * from sinhvien
select * from monhoc
select * from ketqua
---------------A-------------
--A1. Cho biết danh sách các môn học, gồm các thông tin sau: 
--Mã môn học, Tên môn học, Số tiết
select	mh.mamh, mh.tenmh, mh.sotiet
from	monhoc mh
--A4. Thông tin các sinh viên gồm: Họ tên sinh viên, Ngày sinh, 
--Học bổng. Thông tin sẽ được sắp xếp theo thứ tự Ngày sinh tăng dần 
select		HoTen=hosv+' '+tensv, ngaysinh, hocbong
from		sinhvien sv
order by	ngaysinh asc
--A5
select	*
from	monhoc
where	tenmh like 'T%'
--A6. Liệt kê danh sách những sinh viên có chữ cái cuối cùng 
--trong tên là I, gồm các thông tin: Họ tên sinh viên, Ngày sinh, Phái
select	HoTen=hosv+' '+tensv, ngaysinh, phai
from	sinhvien sv
where	tensv like '%i'
--A7. Danh sách những khoa có ký tự thứ hai của tên khoa có 
--chứa chữ N, gồm các thông tin: Mã khoa, Tên khoa
select	*
from	khoa kh
where	kh.tenkh like '_n%'
--A10. Cho biết danh sách những sinh viên mà tên có chứa ký 
--tự nằm trong khoảng từ a đến d, gồm các thông tin: Họ tên 
--sinh viên, Ngày sinh, Nơi sinh, Học bổng. Danh sách được 
--sắp xếp giảm dần theo học bổng sinh viên
select		HoTen=hosv+' '+tensv, ngaysinh, noisinh, hocbong
from		sinhvien sv 
where		tensv like '%[a-d]%'
order by	hocbong desc
--A12. Liệt kê danh sách sinh viên của khoa Tin học, gồm các 
--thông tin sau: Mã sinh viên, Họ tên sinh viên, Ngày sinh. 
--Danh sách sẽ được sắp xếp theo thứ tự Ngày sinh giảm dần
select		masv, HoTen=hosv+' '+tensv, ngaysinh
from		sinhvien sv, khoa kh
where		sv.makh=kh.makh and
			tenkh=N'Tin học'
order by	ngaysinh desc			
--A13. Cho biết danh sách các sinh viên có học bổng lớn hơn 
--100,000, gồm các thông tin: Mã sinh viên, Họ tên sinh viên, 
--Mã khoa, Học bổng. Danh sách sẽ được sắp xếp theo thứ tự 
--Mã khoa giảm dần	
select		masv, HoTen=hosv+' '+tensv, makh, hocbong
from		sinhvien sv	
where		hocbong>100000	
order by	makh desc
--A16. Liệt kê danh sách sinh viên trong khoa Tin học, gồm 
--các thông tin: Họ tên sinh viên, Ngày sinh, Mã khoa, Tên 
--khoa, Mã môn, Điểm. Danh sách được sắp giảm dần theo Điểm, 
--nếu cùng điểm thì sắp tăng dần theo tên sinh viên.
select		HT=hosv+' '+tensv, ngaysinh, sv.makh, tenkh, mamh, diem
from		sinhvien sv, khoa kh, ketqua kq		
where		sv.makh=kh.makh	and
			sv.masv=kq.masv and
			tenkh=N'Tin học'	
order by	diem desc, tensv asc				
----------------B-------------	
--B1. Cho biết các sinh viên sinh sau ngày 20/12/1981, gồm các thông 
--tin: Họ tên sinh viên, Ngày sinh, Nơi sinh, Học bổng. Danh sách sẽ 
--được sắp xếp theo thứ tự ngày sinh giảm dần
select		HoTen=hosv+' '+tensv, ngaysinh, noisinh, hocbong
from		sinhvien sv
where		ngaysinh>'20/12/1981'
order by	ngaysinh desc
--B4. Cho biết những sinh viên có ngày sinh từ ngày 01/01/1978 đến  ngày 
--05/06/1983, gồm các thông tin: Mã sinh viên, Ngày sinh, Nơi sinh, Học bổng
select	masv, ngaysinh, noisinh, hocbong
from	sinhvien sv
where	ngaysinh >= '01/01/1978' and
		ngaysinh <= '05/06/1983'		
select	masv, ngaysinh, noisinh, hocbong
from	sinhvien sv
where	ngaysinh between '01/01/1978' and '05/06/1983'	
--B5. Danh sách những sinh viên có học bổng từ 200,000 xuống đến 80,000, gồm các thông 
--tin: Mã sinh viên, Ngày sinh, Phái, Mã khoa
--Cách 1
select	masv, ngaysinh, phai,makh
from	sinhvien sv
where	hocbong between 80000 and 200000
--Cách 2
select	masv, ngaysinh, phai,makh
from	sinhvien sv
where	hocbong >= 80000 and 
		hocbong <= 200000
--B6. Cho biết những môn học có số tiết lớn hơn 40 và nhỏ hơn 60, gồm các thông 
--tin: Mã môn học, Tên môn học, Số tiết	
select	mamh, tenmh, sotiet
from	monhoc  mh
where	sotiet > 40 and
		sotiet < 60
--B11. Liệt kê kết quả học tập môn Trí tuệ nhân tạo của các sinh viên khoa Anh Văn, gồm các thông tin: Họ tên sinh viên, 
--B11. Ngày sinh, Tên môn, Điểm. Danh sách được sắp xếp giảm dần theo Họ tên sinh viên
select		HoTen=hosv+' '+tensv, ngaysinh, tenmh, diem
from		sinhvien sv, ketqua kq, monhoc mh, khoa kh
where		sv.masv=kq.masv and
			kq.mamh=mh.mamh and
			sv.makh=kh.makh and
			tenmh=N'Trí tuệ nhân tạo' and
			tenkh=N'Anh Văn'
order by	tensv desc, hosv desc	
--B12. Liệt kê danh sách sinh viên trong khoa Tin học, gồm các thông tin: Họ tên sinh 
--viên, Ngày sinh, Mã khoa, Tên khoa, Mã môn, Tên môn, Điểm. Danh sách được sắp giảm 
--dần theo Điểm, nếu cùng điểm thì sắp tăng dần theo Mã môn.
select		HT=hosv+' '+tensv, ngaysinh, kh.makh, tenkh, mh.mamh, tenmh, diem
from		sinhvien sv, khoa kh, ketqua kq, monhoc mh
where		sv.makh=kh.makh	and
			kq.masv=sv.masv and
			kq.mamh=mh.mamh and
			tenkh=N'Tin học'
order by	diem desc, mh.mamh asc			
-------------------C---------------
--C1. Liệt kê danh sách sinh viên gồm các thông tin sau: Họ và tên sinh viên, 
--Giới tính, Ngày sinh. Trong đó Giới tính hiển thị ở dạng Nam/Nữ tuỳ theo 
--giá trị của field Phai là Yes hay No
select	HoTen=hosv+' '+tensv,N'Giới tính'=case when phai=0 then N'Nữ' else 'Nam' end, 
		ngaysinh
from	sinhvien sv
--C3. Cho biết những sinh viên có tuổi lớn hơn 40, thông tin 
--gồm: Họ tên sinh viên, Tuổi, Học bổng	
select	HoTen=hosv+' '+tensv, Tuoi=YEAR(getdate())-YEAR(ngaysinh), hocbong
from	sinhvien sv
where	YEAR(getdate())-YEAR(ngaysinh)>40
--C4. Liệt kê danh sách những sinh viên có tuổi từ 40 đến 50, thông tin gồm: 
--Họ tên sinh viên, Tuổi, Tên khoa
select	HOTENSV=HOSV+' ' +TENSV, TUOI=year(getdate())-year(NGAYSINH), TENKH
from	SINHVIEN sv,KHOA kh
where	sv.MAKH=kh.MAKH and 
		(year(getdate())-year(NGAYSINH)) between 40 and 50
--C5. Liệt kê danh sách sinh viên trên 40 tuổi gồm các thông tin sau: Họ và tên sinh viên, 
--Giới tính, Tuổi, Mã khoa. Trong đó Giới tính hiển thị ở dạng Nam/Nữ tuỳ theo giá trị 
--của field Phai là Yes hay No, Tuổi sẽ được tính bằng cách lấy năm hiện hành trừ cho năm 
--sinh. Danh sách sẽ được sắp xếp theo thứ tự Tuổi giảm dần
--Cách 1
select		HT=hosv+' '+tensv, N'Giới tính'=case when phai=0 then N'Nữ' else 'Nam' end,
			Tuoi=YEAR(getdate())-YEAR(ngaysinh), makh
from		sinhvien
where		YEAR(getdate())-YEAR(ngaysinh)>40
order by	YEAR(getdate())-YEAR(ngaysinh)desc
--Cách 2
select		HT=hosv+' '+tensv, N'Giới tính'=case when phai=0 then N'Nữ' else 'Nam' end,
			Tuoi=YEAR(getdate())-YEAR(ngaysinh), makh
from		sinhvien
where		YEAR(getdate())-YEAR(ngaysinh)>40
order by	Tuoi desc
--C6. liệt kê danh sách sinh viên sinh vào tháng 2 năm 1980, gồm các thông tin: Họ tên 
--sinh viên, Phái, Ngày sinh. Trong đó, Ngày sinh chỉ lấy giá trị ngày của field NGAYSINH. 
--Sắp xếp dữ liệu giảm dần theo cột Ngày sinh
select		HOTENSV=HOSV+' ' +TENSV, phai, N'Ngày sinh'=day(ngaysinh)
from		sinhvien sv	
where		MONTH(ngaysinh)=2 and
			YEAR(ngaysinh)=1980	
order by	ngaysinh desc	
--C7. Cho biết thông tin về mức học bổng của các sinh viên, gồm: Mã sinh viên, Phái, Mã 
--khoa, Mức học bổng. Trong đó, mức học bổng sẽ hiển thị là “Học bổng cao” nếu giá trị 
--của field học bổng lớn hơn 100,000 và ngược lại hiển thị là “Mức trung bình”	
select	masv, phai, makh, 
		N'Mức học bổng'=case when hocbong>100000 then 'Cao' else 'TB' end
from	sinhvien
--C11. (SV hoàn tất) Kết quả học tập của sinh viên, gồm các thông tin: Họ tên sinh viên, 
--Mã khoa, Tên môn học, Điểm thi, Loại. Trong đó, Loại sẽ là Giỏi nếu điểm thi > 8, từ 6 
--đến 8 thì Loại là Khá, nhỏ hơn 6 thì loại là Trung Bình
select		Loai=case when diem>8 then 'G' when diem >=6 and diem<=8 then 'K' else 'TB' end
from		ketqua kq
--------------------------------D-----------------------
--D1. Cho biết trung bình điểm thi theo từng môn, gồm các thông tin: Mã môn, Tên môn, Trung 
--bình điểm thi
select		mh.mamh, mh.tenmh, avg(diem)
from		monhoc mh, ketqua kq
where		mh.mamh=kq.mamh
group by	mh.mamh, mh.tenmh
--D6. Thông tin của môn học có số tiết it nhất, gồm các thông tin: Tên môn học, Số tiết
select		tenmh, sotiet
from		monhoc
where		sotiet=(select		min(sotiet)
					from		monhoc)
--D6'. Thông tin của môn học có số tiết it hon 45, gồm các thông tin: Tên môn học, Số tiết
select		tenmh, sotiet
from		monhoc
where		sotiet<45
--D9. Thống kê số sinh viên học của từng môn, thông tin gồm có: Mã môn, Tên môn, Số sinh viên 
--đang học (liệt kê cả các môn học chưa có sinh viên nào dự thi)
select		*
from		ketqua kq, monhoc mh
where		kq.mamh=mh.mamh

select		*
from		ketqua kq inner join monhoc mh on kq.mamh=mh.mamh

select		*
from		ketqua kq right outer join monhoc mh on kq.mamh=mh.mamh

select		mh.mamh, tenmh, SL=count(masv)
from		ketqua kq right outer join monhoc mh on kq.mamh=mh.mamh
group by	mh.mamh, tenmh
--D11. Cho biết khoa nào có nhieu sinh viên nhất, bao gồm: Mã khoa, Tên khoa, Tổng số sinh 
--viên
select		sv.makh, count(*)
from		sinhvien sv
group by	sv.makh
having		count(*) >=all (select		count(*)
							from		sinhvien sv
							group by	sv.makh)

select		sv.makh, count(*)
from		sinhvien sv
group by	sv.makh
having		count(*) = (select		top 1 count(*)
							from		sinhvien sv
							group by	sv.makh
							order by	count(*) desc)
---D12. Cho biết khoa nào có sinh viên lãnh học bổng cao nhất, gồm các thông tin sau: Tên khoa, Họ
--tên sinh viên, Học bổng
select distinct	tenkh,N'Họ tên sinh viên'=hosv+' '+tensv,hocbong
from		khoa kh,sinhvien sv
where		kh.makh=sv.makh and		
			hocbong= (	select		max(hocbong)
						from		sinhvien sv
						)

--D13 Cho biết sinh viên của khoa Tin học có có học bổng cao nhất, gồm các thông tin: Mã sinh viên,
--Họ sinh viên, Tên sinh viên, Tên khoa, Học bổng
select 	tenkh,N'Họ tên sinh viên'=hosv+' '+tensv,hocbong
from		khoa kh,sinhvien sv
where		kh.makh=sv.makh and	
			tenkh=N'Tin học'and
			hocbong= (	select		max(hocbong)
						from		sinhvien sv	)
--D14 Cho biết sinh viên nào có điểm môn Nhập môn máy tính lớn nhất, bao gồm các thông tin:
 --Học sinh viên, Tên môn, Điểm
 select  N'Họ tên sinh viên'=hosv+' '+tensv,tenmh,diem
 from sinhvien sv,monhoc mh,ketqua kq
 where sv.masv=kq.masv and
		mh.mamh=kq.mamh and
		tenmh=N'Nhập môn máy tính' and
		diem =(	select max(diem)
				from ketqua)
--D15. Cho biết  3 sinh viên có điểm thi môn Đồ hoạ thấp nhất, thông tin bao gồm: Họ tên sinh 
--viên, Tên khoa, Tên môn, Điểm
select		top 3 hosv, tensv, tenkh, tenmh, diem
from		ketqua kq, monhoc mh, sinhvien sv, khoa kh
where		kq.mamh=mh.mamh and
			kq.masv=sv.masv and
			sv.makh=kh.makh and
			tenmh=N'Đồ họa'
order by	diem asc
--D16  Cho biết khoa nào có nhiều sinh viên nữ nhất, gồm các thông tin: Mã khoa, Tên khoa
select makh,tenkh
from khoa kh

--D17. Thống kê sinh viên theo khoa, gồm các thông tin: Mã khoa, Tên khoa, Tổng số  sinh viên, 
--Tổng số sinh viên nam, Tổng số sinh viên nữ (kể cả những khoa chưa có sinh viên).
select		kh.makh, tenkh, count(masv), SLNu=sum(case when phai=0 then 1 end), 
			SLNam=sum(case when phai=1 then 1 end)
from		sinhvien sv right outer join khoa kh on sv.makh=kh.makh
group by	kh.makh, tenkh
--D18'. Cho biết cac sinh viên khong co mon hoc nao diem duoi 4, gồm Họ tên sinh viên, Tên 
--khoa 
select		hosv, tensv
from		sinhvien sv, khoa kh
where		sv.makh=kh.makh and
			masv not in (select		masv
						from		ketqua kq
						where		diem<4) 						
--D18. Cho biết kết quả học tập của sinh viên, gồm Họ tên sinh viên, Tên khoa, Kết quả. 
--Trong đó, Kết quả sẽ là Đậu nếu không có môn nào có điểm nhỏ hơn 4
select		hosv, tensv, tenkh, Ketqua=case when tam.masv is null then N'Đậu' end
from		sinhvien sv left outer join (select		masv
										from		ketqua kq
										where		diem<4) as tam on tam.masv = sv.masv 
						inner join khoa kh on sv.makh=kh.makh
--D19 Danh sách những sinh viên không có môn nào nhỏ hơn 4 điểm, gồm các thông tin: Họ tên sinh
--viên, Tên khoa, Giới tính. Trong đó Giới tính hiển thị Nam/Nữ
select hotensv = hosv+ ' '+tensv, tenkh,gioitinh = case when phai = 1 then N'Nam' else N'Nu' end, diem
from sinhvien sv , khoa kh , ketqua kq 
where	sv.makh = kh.makh and 
		kq.masv = sv.masv   and kq.masv not in (
											select	masv
											from	ketqua kq 
											where	 diem<4	)  
--D20 . Cho biết danh sách những môn không có điểm thi nhỏ hơn 4, gồm các thông tin: Mã môn, Tên
--Môn
select kq.mamh , tenmh, diem
from sinhvien sv , khoa kh , ketqua kq , monhoc 
where	sv.makh = kh.makh and 
		kq.masv = sv.masv   and kq.masv not in (
											select	masv
											from	ketqua kq 
											where	 diem<4	)
--21. Cho biết những khoa không có sinh viên rớt, sinh viên rớt nếu điểm thi của môn nhỏ hơn 5,
--gồm các thông tin: Mã khoa, Tên khoa  

select kh.makh,tenkh
from sinhvien sv , khoa kh 
where	sv.makh = kh.makh and 
							masv not in (
											select	masv
											from	ketqua kq 
											where	 diem>5	)

--22.Thống kê số sinh viên đậu và số sinh viên rớt của từng môn, biết rằng sinh viên rớt khi điểm
--của môn nhỏ hơn 5, gồm có: Mã môn, Tên môn, Số sinh viên đậu, Số sinh viên rớt (kể cả những
--môn chưa có sinh viên dự thi)

select mh.mamh ,tenmh , N'So sinh vien dau ' = sum(case when diem > 5 then 1 end) , N'So sinh vien rot ' = sum(case when diem < 5 then 1 end)
from ketqua kq right outer join monhoc mh on kq.mamh = mh.mamh
group by mh.mamh, tenmh 
--D23 Cho biết môn nào không có sinh viên rớt, gồm các thông tin: Mã môn, Tên môn
select  mh.mamh , tenmh 
from monhoc mh , ketqua kq, sinhvien sv
where kq.masv = sv.masv and diem < 5
group by mh.mamh , tenmh
having count(*) >0
--D24. Danh sách sinh viên không có môn nào rớt, thông tin gồm: Mã sinh viên, Họ tên, Mã khoa
select  sv.masv , N'Ten sv'  = hosv + ' '+tensv , makh  
from monhoc mh , ketqua kq, sinhvien sv
where kq.mamh = mh.mamh and diem < 5
group by sv.masv, makh , hosv + ' '+tensv
having count(*) >1
--d25
--D26 Cho biết danh sách những khoa có nhiều hơn 10 sinh viên, gồm Mã khoa, Tên khoa, Tổng số
--sinh viên của khoa
select kh.tenkh , N'Tong so sinh vien cua khoa' = count(sv.masv)
from khoa kh , sinhvien sv
where sv.makh  = kh.makh	
group by kh.tenkh 
having count(sv.masv) >=2	
--D27. Danh sách những sinh viên thi nhiều hơn 3 môn, gồm có Mã sinh viên, Họ tên sinh viên, Số môn
--thi
select sv.masv , N'Ho ten sv' = hosv + ' ' +tensv , N'So mon thi' = count(mh.mamh)
from  sinhvien sv, monhoc mh , ketqua kq
where	 mh.mamh = kq.mamh	and
		kq.masv = sv.masv
group by sv.masv, hosv,tensv
having count(mh.mamh) >=3	
---28. Cho biết khoa có 3 sinh viên nam trở lên, thông tin gồm có: Mã khoa, Tên khoa, Tổng số sinh
--viên nam

select kh.makh, tenkh , N'Tong so sinh vien' = sum(case when phai = 1 then 1 end)
from khoa kh , sinhvien sv
where kh.makh  = sv.makh
group by kh.makh, kh.tenkh
having sum(case when phai = 1 then 1 end) >=1	
--29. Danh sách những sinh viên có trung bình điểm thi lớn hơn 4, gồm các thông tin sau: Họ tên
--sinh viên, Tên khoa, Giới tính, Điểm trung bình các môn

select		N'Ho ten sv' = hosv + ' ' +tensv, kh.tenkh, N'gioi tinh' = case when phai  = 1 then 'Nam' else 'Nu' end,
			N'Diem trung binh cac mon' = AVG(diem)
from		sinhvien sv, khoa kh, ketqua kq
where		sv.masv = kq.masv and
			sv.makh = kh.makh 
group by	hosv, tensv , kh.tenkh, phai
having		AVG(diem) >4
--30--Cho biết trung bình điểm thi của từng môn, chỉ lấy môn nào có trung bình điểm thi lớn hơn 6,
--thông tin gồm có: Mã môn, Tên môn, Trung bình điểm
select mh.mamh , tenmh , N'Diem TB' = AVG(diem) 
from monhoc mh , ketqua kq
where mh.mamh = kq.mamh 
group  by mh.mamh , tenmh
having AVG(diem) >6