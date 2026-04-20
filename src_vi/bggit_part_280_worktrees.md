# Worktree (Cây Làm Việc)

[i[Worktree]<]

Giả sử bạn có code ở một cửa sổ và đang vui vẻ nhìn vào `main`. Rồi bạn nghĩ, "Sẽ tốt nếu có thể nhìn vào một số file trên `foobranch` một lúc."

Nhưng bạn đang làm dở việc gì đó trên `main`. Vậy là bạn phải trải qua rắc rối khi lưu, stash, switch sang `foobranch`, nhìn vào thứ bạn cần, rồi switch lại, pop stash, và chỉnh sửa file.

Và sau đó chính xác 2.3 giây sau, bạn nhận ra bạn cần nhìn vào `foobranch` lại. Ugh.

Bạn không thể checkout hai nhánh cùng lúc trong cùng một working tree. Vậy bạn phải làm gì nếu muốn nhìn vào cả hai cùng lúc?

Tất nhiên, bạn có thể tạo thêm một clone, nhưng điều đó có thể là cấm kỵ nếu lượng dữ liệu trong clone là lớn. Bạn có thể làm shallow clone... nhưng giờ nó trông có vẻ hacky rồi.

Hóa ra *worktree* cho chúng ta một cách tốt hơn. Với `git worktree`, bạn có thể tạo một working tree riêng biệt khác ở một nhánh khác. Và sau đó nhìn vào cả hai chỉ là vấn đề `cd` hoặc có hai cửa sổ terminal mở cùng lúc.

## Quy Tắc Của Worktree

Hãy ghi chú nhanh ở đây về một số quy tắc cơ bản.

1. Không có hai worktree nào (trong cùng một repo) được tham chiếu đến cùng một nhánh vào cùng một lúc. Tức là, tất cả worktree phải tham chiếu đến các nhánh khác nhau. Nếu bạn cố switch sang `main` trên hai worktree đồng thời, Git sẽ ngăn bạn.

2. [i[Worktree-->Choosing location]]Bạn có thể đặt worktree mới ở bất kỳ đâu bạn muốn. Nhưng khuyến nghị mạnh mẽ của tôi là đặt nó *bên ngoài* working tree hiện có, như một thư mục anh em.

3. Bạn có thể chạy tất cả lệnh Git thông thường từ bất kỳ working tree nào, bao gồm commit, push, và pull.

4. Worktree **không** phải là clone. Nó là một cách nhìn khác vào repo. Commit được tạo trong một working tree có sẵn ngay lập tức (nhưng không tự động switch) trong cái kia vì cả hai working tree đang nhìn vào cùng một repo cục bộ! (Không giống clone, nơi hai clone sẽ được liên kết với cùng một *remote* repo.)

5. [i[Worktree-->`main` worktree]]Chỉ có một trong các worktree là *thực* (được gọi là "main working tree", không liên quan đến nhánh `main`). Các cái khác không có thư mục `.git` thực sự. Đừng xóa cái thực trừ khi bạn muốn mất tất cả metadata git! Luôn dùng `git worktree remove` để xóa worktree vì nó sẽ từ chối xóa cái chính nếu bạn dại dột thử làm vậy.

Với đống legalese (lời lẽ pháp lý) nhàm chán đó xong rồi, hãy làm gì đó đi!

## Tạo một Worktree Mới

[i[Worktree-->Creating]<]

Giả sử bạn đang ở root của một repo gọi là `wumpus` trên nhánh `main`. Và bạn muốn nhìn vào một nhánh khác gọi là `arrow` trong một working tree mới.

Chúng ta sẽ dùng `git worktree add` và cho nó hai thứ.

1. Tên thư mục nơi worktree sẽ đặt. Vì tôi đang checkout nhánh `arrow` trên repo `wumpus` ở đó, tôi sẽ gọi nó là `../wumpus-arrow`. Bạn có thể gọi là gì cũng được.

   Cũng chú ý `../`; đó là để lên thư mục cha để `wumpus-arrow` sẽ được tạo như một thư mục anh em với `wumpus`.

2. Chúng ta cũng cần cho nó biết nhánh cần switch trong worktree đó. Một lần nữa, đây không thể là nhánh đang được checkout trong bất kỳ working tree nào khác.

Hãy làm thôi!

``` {.default}
$ git worktree add ../wumpus-arrow arrow 
  Preparing worktree (checking out 'arrow')
  HEAD is now at 7da9b7f fix arrow flight
```

Đó rồi. Bây giờ chúng ta có thể `cd` đến thư mục đó và nhìn xung quanh.

``` {.default}
$ cd ../wumpus-arrow
$ git status
  On branch arrow
  nothing to commit, working tree clean
```

Hoặc bạn có thể mở hai cửa sổ. Một ở thư mục `wumpus/` để xem nhánh `main`, và cái kia ở thư mục `wumpus-arrow/` để xem nhánh `arrow`.

[i[Worktree-->Creating]>]

## Xóa một Worktree

[i[Worktree-->Removing]<]

Trước tiên, hãy chắc chắn bạn không có bất kỳ sửa đổi chưa commit nào trong worktree sắp xóa. Sau đó xác định đường dẫn đến nó. Và sau đó xóa nó.

Giả sử chúng ta đang ở thư mục `wumpus/` từ ví dụ trước. Từ đó, tôi có thể xóa worktree `wumpus-arrow/` như thế này:

``` {.default}
$ git worktree remove ../wumpus-arrow
```

Và thế là xong.

Một lần nữa, điều này không xóa bất kỳ commit nào bạn đã tạo từ worktree đó; worktree chỉ là một cái nhìn vào cùng repo với main working tree, vì vậy commit đã được lưu trong repo ngay từ khi bạn tạo chúng từ bất kỳ worktree nào.

Đường dẫn bạn chỉ định cho `worktree remove` không nhất thiết phải khớp ký tự-cho-ký tự với đường dẫn bạn đã dùng với `worktree add`. Nó chỉ cần tham chiếu đến cùng thư mục.

Ví dụ, nếu tôi đang ở thư mục `wumpus/`, điều này sẽ thực hiện tương tự như ví dụ đầu tiên:

``` {.default}
$ cd ..
$ git worktree remove wumpus-arrow
```

Bạn thậm chí có thể xóa worktree bạn đang ở ngay lúc này:

``` {.default}
$ git worktree remove .
```

Và, cuối cùng, nếu bạn cố xóa main working tree, bạn sẽ bị cảnh sát Git ngăn lại.

``` {.default}
$ git worktree remove wumpus
  fatal: 'wumpus' is a main working tree
```

[i[Worktree-->Removing]>]

## Liệt Kê Worktree

[i[Worktree-->Listing]<]

Bạn có thể thấy tất cả worktree và xác định worktree nào là main working tree với lệnh `worktree list`.

``` {.default}
$ git worktree list
  /home/user/wumpus        30d669a [main]
  /home/user/wumpus-arrow  7da9b7f [arrow]
```

Lệnh đó sẽ hiển thị tất cả working tree với thư mục ở bên trái, commit hash ở giữa, và tên nhánh ở bên phải.

Worktree đầu tiên được liệt kê là main working tree, tức là cái bạn không thể xóa.

[i[Worktree-->Listing]>]

## Worktree và `HEAD` Bị Detach

[i[Worktree-->Detached `HEAD`]<]

Bạn không thể có cùng một nhánh được checkout trong hai worktree trên cùng repo vì điều đó có nghĩa là hai worktree sẽ tranh giành nhau quyền đặt một tham chiếu nhánh duy nhất.

[i[`HEAD`-->Detached]<]

Tuy nhiên, cả hai worktree đều có `HEAD` riêng của mình! Không có xung đột ở đó. Vì vậy bạn có thể có một worktree trên `main` và cái kia với `HEAD` bị detach tại cùng commit với `main`. Tất nhiên, bất kỳ commit nào trên `HEAD` bị detach sẽ không di chuyển `main` chút nào, vì vậy không có xung đột.

``` {.default}
$ cd ../wumpus-arrow

$ git switch --detach main
  HEAD is now at 30d669a add drafts

$ git worktree list
  /home/user/wumpus        30d669a [main]
  /home/user/wumpus-arrow  30d669a (detached HEAD)
```

Trong ví dụ đó, chúng ta thấy cả hai worktree đang trỏ đến cùng commit `30d669a` nhưng không sao vì chúng không được checkout tại cùng nhánh.

Bạn cũng có thể thêm worktree mới với `HEAD` bị detach như trong ví dụ tiếp theo, nơi chúng ta detach `HEAD` của worktree mới tại commit `main`.

``` {.default}
$ git worktree add --detach ../wumpus-worktree main
```

Cuối cùng, nếu bạn chỉ định commit hash thay vì nhánh khi tạo worktree mới, nó sẽ tự động được tạo với `HEAD` bị detach.

[i[Worktree-->Detached `HEAD`]>]
[i[`HEAD`-->Detached]>]
[i[Worktree]>]
