## Bài 2: Caching with Redis
- Viết một web server sử dụng gin go + redis với
- 1 API /login, để tạo session cho mỗi người đăng nhập, dùng redis để lưu session id, user name ấy
- 1 API /ping chỉ cho phép 1 người được gọi tại một thời điểm ( với sleep ở bên trong api đó trong 5s)
- đếm số lượng lần 1 người gọi api /ping
- rate limit mỗi người chỉ được gọi API /ping 2 lần trong 60s
- 1 API /top/ trả về top 10 người gọi API /ping nhiều nhất
- Dùng hyperloglog để lưu xấp sỉ số người gọi api /ping , và trả về trong api /count
