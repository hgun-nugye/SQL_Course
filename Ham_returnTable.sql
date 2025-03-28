Create function MH_SLB ()
returns table
as
return
(select MH.[MAHANG],MH.[TENHANG],  sum(CT_DH.[SOLUONG]) as SL_Ban from [dbo].[MATHANG] MH join [dbo].[CTDONHANG] CT_DH
on MH.[MAHANG] = CT_DH.[MAHANG]
group by MH.[MAHANG], MH.[TENHANG] )

SELECT * FROM MH_SLB();