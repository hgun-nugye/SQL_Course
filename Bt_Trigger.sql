--Câu 2.10: Function: Truyền vào mã nhân viên, cho biết họ tên đầy đủ của nhân viên đó
create function HoTenNV 
	(@MANV nvarchar(5))
returns nvarchar(60)
as
begin
	declare @Ho nvarchar(20),@Tenlot nvarchar(20), @Ten nvarchar(20)
	select 
	@Ho=[HONV],
	@Tenlot=[TENLOT],
	@Ten=[TENNV]
	from [dbo].[NHANVIEN]
	where MANV=@MANV
	return @Ho + ' ' + @Tenlot+ ' '+ @Ten;
end;

select [dbo].[HoTenNV]('NV5') as HovaTen;