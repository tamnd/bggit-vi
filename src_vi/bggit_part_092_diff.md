# So Sánh File với Diff {#diff}

[i[Diff]<]

Lệnh `git diff` mạnh mẽ có thể cho bạn thấy sự khác biệt giữa hai file hay hai commit. Ta đã đề cập đến nó thoáng qua ở đầu, nhưng ở đây ta sẽ đi sâu hơn vào tất cả những gì bạn có thể làm với nó.

Đầu ra không phải là thứ dễ đọc lúc đầu, nhưng bạn sẽ quen dần sau một thời gian. Trường hợp dùng phổ biến nhất của tôi là nhanh chóng xem lại để nhớ mình đã thay đổi gì trong working tree để biết cần add gì vào stage và dùng commit message gì.

## Cách Dùng Cơ Bản

[i[Diff-->Understanding the output]<]

Trường hợp cơ bản nhất là bạn đã sửa đổi một số file trong working tree và muốn xem sự khác biệt giữa trạng thái trước và những gì bạn đã thêm vào.

Ví dụ, giả sử tôi đã sửa đổi file `hello.py` (nhưng chưa stage). Tôi có thể kiểm tra những gì đã thay đổi như sau:

``` {.default}
$ git diff
  diff --git a/hello.py b/hello.py
  index 4a8f53f..8ee1fe4 100644
  --- a/hello.py
  +++ b/hello.py
  @@ -1,4 +1,8 @@
   def hello():
  -    print("Hello, world!")
  +    print("HELLO, WORLD!")
  +
  +def goodbye():
  +    print("See ya!")

   hello()
  +goodbye()
```

Chúng ta có gì ở đó? Ồ, một mớ ký hiệu khó hiểu, dĩ nhiên rồi!

_Hết_

Thôi được, hít thở sâu vào rồi ta sẽ tìm hiểu nhé.

Vì đầu ra trải đầy `hello.py`, ta có thể tự tin cho rằng đây là file ta đang nói đến. Nếu diff báo cáo trên nhiều file (ví dụ bạn đang so sánh hai commit), mỗi file sẽ có phần riêng trong đầu ra.

> **Dòng `index` chứa blob hash và quyền của file.** Blob hash là hash
> của file cụ thể ở các trạng thái đang được so sánh. Đây thường không
> phải thứ bạn cần lo lắng. Hay thậm chí không bao giờ cần.

Sau đó ta có một vài dòng cho biết phiên bản cũ của file `a/hello.py` được đánh dấu bằng dấu trừ, còn phiên bản mới (chưa stage) là `b/hello.py` và được đánh dấu bằng dấu cộng.

Rồi ta có `@@ -1,4 +1,8 @@`. Điều này có nghĩa là dòng 1-4 trong phiên bản cũ được hiển thị, và dòng 1-8 trong phiên bản mới được hiển thị. (Vậy rõ ràng ta đã thêm ít nhất một số dòng ở đây.)

Cuối cùng, ta đến với phần thịt và khoai của cả câu chuyện --- thực sự đã thay đổi gì? Nhớ rằng phiên bản cũ là dấu trừ và phiên bản mới là dấu cộng, hãy nhìn vào phần đó của diff một lần nữa:

``` {.default}
   def hello():
  -    print("Hello, world!")
  +    print("HELLO, WORLD!")
  +
  +def goodbye():
  +    print("See ya!")

   hello()
  +goodbye()
```

Quy tắc:

* Nếu một dòng có tiền tố `-`, nghĩa là dòng đó trong phiên bản cũ là như vậy.

* Nếu một dòng có tiền tố `+`, nghĩa là dòng đó trong phiên bản mới, đã sửa đổi, là như vậy.

* Nếu một dòng không có tiền tố gì, nghĩa là nó không thay đổi giữa các phiên bản.

> **Diff sẽ không hiển thị cho bạn tất cả các dòng của file!** Nó chỉ
> hiển thị những gì đã thay đổi và một số dòng xung quanh. Nếu có thay
> đổi ở các phần khác nhau của file, các phần không thay đổi sẽ bị bỏ
> qua trong diff.

Một cách khác để đọc diff là các dòng có `-` đã bị xóa và các dòng có `+` đã được thêm vào.

[i[Diff-->Understanding the output]>]

## Diff Trên Stage

[i[Diff-->The stage]<]

Nếu bạn đã add một số thứ vào stage và muốn diff nó với commit trước?

Chỉ gõ `git diff` sẽ không hiện gì cả!

Tại sao? Vì diff, theo mặc định, hiển thị *sự khác biệt giữa working tree và stage*. Bạn vừa stage file đó, sao chép nó từ working tree lên stage, vì vậy hai cái giống hệt nhau. Nên diff không thấy sự khác biệt nào.

Làm thế nào để diff stage với commit trước?

Câu trả lời thực sự đơn giản: `git diff --staged`[^91c6]. Xong.

[^91c6]: Flag `--staged` hiện đại hơn. Các phiên bản Git cũ dùng
    `git diff --cached`.

Nhưng tôi muốn dùng phần này để đào sâu hơn một chút về những gì đang xảy ra để bạn hiểu rõ hơn cách hoạt động của nó.

Đến giờ dùng mô hình tư duy!

Giả sử hai điều sau đây là đúng. Thực ra đúng hay không không quan trọng lắm.

> _"Đó chỉ là một mô hình thôi."_\
> \ \ \ \ \ \ \ \ \ \ \ \ ---Patsy, _Monty Python and the Holy Grail_

1. Stage chứa một _bản sao_ của **tất cả** file chưa sửa đổi tại commit hiện tại của bạn.

2. `git status` hay `git diff` chỉ hiển thị file khác nhau giữa working tree và stage.

Vậy nếu bạn không có sửa đổi nào, `git diff` sẽ không hiện sự khác biệt nào. Vì stage và working tree giống nhau.

Bây giờ nếu bạn sửa đổi một file trong working tree rồi `git diff`, bạn *sẽ* thấy một số thay đổi, vì working tree khác với stage.

Nhưng sau đó nếu bạn add file đã sửa đổi vào stage, thì stage và working tree lại giống nhau. Và `git diff` sẽ không hiện sự khác biệt.

*`git diff` **luôn luôn** so sánh working tree với stage.* (Trừ khi bạn đang diff các commit cụ thể --- xem bên dưới.) Và trong trường hợp này, sau khi bạn đã add file đã sửa đổi vào stage, nó giống với working tree. Vậy không có diff nào.

So sánh điều này với trường hợp bạn đã sửa đổi working tree nhưng *chưa* add file vào stage. Trong trường hợp này, file trên stage giống như commit cuối, khác với working tree. Vì vậy `git diff` hiển thị sự khác biệt.

Được rồi... vậy nếu bạn *muốn* diff những gì trên stage với commit cuối? Nghĩa là thay vì diff working tree với stage, bạn muốn diff stage với `HEAD`?

Trở lại câu kết luận:

``` {.default}
$ git diff --staged
```

Và xong. Lệnh này sẽ chạy diff giữa những gì trên stage và commit cuối, hiển thị cho bạn những thay đổi bạn đã stage.

[i[Diff-->The stage]>]

## Thêm Các Trò Hay Với Diff

Hãy nhanh chóng xem qua một số ví dụ về những gì bạn có thể làm với diff.

### Diff Bất Kỳ Commit hay Branch

[i[Diff-->Other commits]]
[i[Diff-->Other branches]]
Bạn có nhiều lựa chọn hơn là chỉ diff working tree hay stage. Bạn thực sự có thể diff bất kỳ hai commit nào. Điều này sẽ hiển thị tất cả sự khác biệt giữa chúng.

Ví dụ, nếu bạn biết commit hash, bạn có thể diff trực tiếp:

``` {.default}
$ git diff d977 27a3
```

Hoặc nếu bạn có tên hai branch:

``` {.default}
$ git diff main topic
```

Hay kết hợp:

``` {.default}
$ git diff main 27a3
```

Hay dùng `HEAD`:

``` {.default}
$ git diff HEAD 27a3
```

Hay `HEAD` tương đối... Cái này diff commit trước-`HEAD` với `HEAD`:

``` {.default}
$ git diff HEAD^ HEAD
```

Và cái này diff bốn commit trước `HEAD` với ba commit trước `HEAD`:

``` {.default}
$ git diff HEAD~4 HEAD~3
```

### Thứ Tự Khi Diff

Đây là hai cách hợp lệ để diff, nhưng cho kết quả khác nhau (ngược nhau):

``` {.default}
$ git diff main topic
$ git diff topic main
```

Một cách nghĩ về điều này là:

``` {.default}
$ git diff FROM TO
```

Nghĩa là, "Này Git, hãy cho tôi biết những thay đổi tôi cần thực hiện để đi từ commit `FROM` đến commit `TO`."

Giả sử tôi đã tạo file `foo.md` và commit nó với một dòng duy nhất `First` trong đó. Và sau đó tôi ghi đè nó bằng `Second` và commit lại.

Trong ví dụ này, tôi có thể hỏi, "Tôi phải thay đổi gì từ commit trước-`HEAD` để đến commit `HEAD`?"

``` {.default}
$ git diff HEAD^ HEAD
  diff --git a/foo.md b/foo.md
  index d00491f..495a7e9 100644
  --- a/foo.md
  +++ b/foo.md
  @@ -1 +1 @@
  -First
  +Second
```

Nó nói với tôi rằng để đi từ trước-`HEAD` đến `HEAD`, tôi cần xóa `First` và thêm `Second`.

Nhưng nếu tôi đảo ngược và hỏi, "Tôi phải thay đổi gì từ `HEAD` để quay về commit trước-`HEAD`?" Tôi sẽ nhận được điều ngược lại:

``` {.default}
$ git diff HEAD HEAD^
  diff --git a/foo.md b/foo.md
  index 495a7e9..d00491f 100644
  --- a/foo.md
  +++ b/foo.md
  @@ -1 +1 @@
  -Second
  +First
```

Ở đó nó nói với tôi rằng để quay về trước-`HEAD` tôi cần xóa `Second` và thêm `First`.

Vậy nhớ nhé, `git diff FROM TO` nói với bạn những thay đổi cần thực hiện để đi từ commit `FROM` đến commit `TO`.

### Diff Với Commit Cha

[i[Diff-->Parent commit]]
Ta vừa thấy ví dụ này:

``` {.default}
$ git diff HEAD~4 HEAD~3
```

Nhưng vì `HEAD~4` là cha của `HEAD~3`, có cách viết tắt nào không? Có!

``` {.default}
$ git diff HEAD~4 HEAD~3
$ git diff HEAD~3^!          # Same thing!
```

Bạn có thể dùng ký hiệu này bất cứ khi nào muốn so sánh một commit với cha của nó, thực chất là hiển thị chỉ những thay đổi trong một commit cụ thể đó.

``` {.default}
$ git diff HEAD^!
$ git diff HEAD~3^!
$ git diff main^!
$ git diff 27a3^!
```

### Thêm Ngữ Cảnh

[i[Diff-->Additional context]]
Theo mặc định, `git diff` hiển thị 3 dòng ngữ cảnh xung quanh các thay đổi. Nếu bạn muốn thêm, ví dụ 5 dòng, hãy dùng tùy chọn `-U`.

``` {.default}
$ git diff -U5
```

### Chỉ Tên File

[i[Diff-->File names only]]
Nếu bạn chỉ muốn danh sách các file đã thay đổi, bạn có thể dùng tùy chọn `--name-only`.

``` {.default}
$ git diff --name-only
```

### Bỏ Qua Khoảng Trắng

[i[Diff-->Ignore whitespace]]
Đôi khi bạn gặp sự nhầm lẫn tab/spaces trong mã nguồn, thứ luôn gây đau đầu. Lời khuyên chuyên nghiệp: chọn một loại và bắt mọi người trong team phải tuân theo dưới hình phạt là phải trả tiền bữa ăn trưa.

Nhưng bạn có thể bảo `git diff` bỏ qua khoảng trắng trong so sánh:

``` {.default}
$ git diff -w
$ git diff --ignore-all-space    # Same thing
```
### Chỉ Các File Nhất Định

[i[Diff-->Specific files]]
Bạn có thể chỉ diff một số file nhất định.

Một cách là đặt tên file sau `--`:

``` {.default}
$ git diff -- hello.py
$ git diff -- hello.py another_file.py
```

Bạn cũng có thể chỉ định commit hay branch trước `--`:

``` {.default}
$ git diff somebranch -- hello.py
```

Lệnh đó sẽ so sánh `hello.py` trong working tree với phiên bản trên `somebranch`.

Hoặc bạn có thể đưa ra hai commit hay branch để so sánh file ở đó:

``` {.default}
$ git diff main somebranch -- hello.py
```

Cuối cùng, bạn có thể giới hạn bằng phần mở rộng file dùng glob và dấu nháy đơn:

``` {.default}
$ git diff '*.py'
```

Lệnh đó chỉ diff các file Python.

### Diff Giữa Các Branch

[i[Diff-->Between branches]]
Đây là một phiên bản thú vị để so sánh hai branch.

Ta đã thấy ví dụ sau để so sánh các commit tại hai branch:

``` {.default}
$ git diff branch1 branch2
```

Nhưng đôi khi bạn muốn biết những gì đã thay đổi trong một branch *kể từ khi hai branch phân kỳ*.

Nghĩa là bạn không muốn biết hiện tại `branch1` và `branch2` khác nhau thế nào, đó là điều lệnh trên sẽ cho bạn.

Bạn muốn biết `branch2` đã thêm hay xóa gì mà `branch1` không có.

Để thấy điều này, bạn có thể dùng ký hiệu:

``` {.default}
$ git diff branch1...branch2
```

Điều này có nghĩa là "diff tổ tiên chung của `branch1` và `branch2` với `branch2`."

Nói cách khác, hãy cho tôi biết tất cả các thay đổi được thực hiện trong `branch2` mà `branch1` chưa biết đến. Đừng hiển thị bất cứ thứ gì mà `branch1` đã thay đổi kể từ khi chúng phân kỳ.

## Difftool

Tôi biết đầu ra diff khó đọc. Tôi khuyến nghị thực hành và tự đề xuất bản thân làm bằng chứng sống rằng với đủ thực hành, đầu ra sẽ trở nên xuyên thủng được. Và cuối cùng thậm chí sẽ dễ đọc, điều này có thể khó tưởng tượng. Nhưng quả thật vậy!

Nói vậy, có các công cụ bên thứ ba giúp diff dễ quản lý hơn, và Git hỗ trợ những công cụ này. Bạn có thể đọc thêm trong chương [diff tool](#difftool).

[i[Diff]>]
