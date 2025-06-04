--Câu 2.10: Function: Truyền vào mã nhân viên, cho biết họ tên đầy đủ của nhân viên đó
create function HoTenNV 
	(@MANV nvarchar(5))
returns nvarchar(60)
as
begin
	return
	( select NV.[HONV] +' '+ NV.[TENLOT] +' '+ NV.[TENNV] as N'Họ và tên'
	from [dbo].[NHANVIEN] NV
	where MANV=@MANV)
end

select [dbo].[HoTenNV]('NV1') as HovaTen;