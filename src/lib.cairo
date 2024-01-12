const ONE_HOUR_IN_SECONDS: u32 = 3600;

#[derive(Drop)]
struct Rectangle {
    width: u64,
    height: u64
}

#[derive(Drop)]
struct Rectangle1<T> {
    width: T,
    height: T
}

trait RectangleTrait {
    fn area(self: @Rectangle) -> u64;
}

trait RectangleTrait1<T> {
    fn area(self: @Rectangle1<T>) -> T;
}

impl RectangleImpl1<T, +Mul<T>, +Copy<T>> of RectangleTrait1<T> {
    fn area(self: @Rectangle1<T>) -> T {
        *self.width * *self.height
    }
}

fn main() {
    let mut x = 5;
    println!("Hello, world! {}", x);

    x = 6;
    println!("Hello, world! {}", x);

    println!("ONE_HOUR_IN_SECONDS is {ONE_HOUR_IN_SECONDS}");

    let mut y: u16 = 10;
    y = y / 2;
    println!("y is {y}");

    let z: u256 = 10;
    let l = 5_u8;
    println!("z is {z} and l is {l}");
    println!("z + l is {}", z + l.into());
    println!("l / y is {}", l / y.try_into().unwrap());

    let x = 'Hello World';
    println!("x is {x}"); // x is 87521618088882533792115812

    let x = 25_u16;
    println!("{}", format!("https://example.com/{}", x));

    let y: ByteArray = "Hello World";
    println!("y is {y}");
    println!("{y:?}");

    println!("{}", sum_three(1, 2, 3));

    println!("{}", min(1, 2));
    println!("{}", min2(1, 2, 3));
    println!("fib: {}", fib(1, 2, 5));

    let a = array![1, 2, 3, 4, 5];
    println!("sum_array! {}", sum_array(a));
    // println!("Arr Len is {}", a.len());  error: Variable was previously moved.

    let (a, b, c) = (1, 2, 3);
    println!("sum_three: {}", sum_three(a, b, c));
    println!("A is {a}");

    let arr = array![1, 2, 3, 4, 5];
    // println!("arr len is {}", return_len(@arr));
    println!("arr len is {}", return_len(arr.span()));
    // println!("arr len {}", arr.len());  error: Variable was previously moved.
    println!("arr len {}", arr.len());
    // 快照传参 @ 会获得变量的不可变引用
    // 可变引用传参

    println!("sum_array2: {}", sum_array2(arr.span()));

    let mut arr = array![1, 2, 3, 4];
    println!("sum_array3: {}", sum_array3(ref arr));
    println!("arr len is {}", arr.len());

    let rectangle = Rectangle { width: 30, height: 50 };
    let area = area(@rectangle);
    println!("area is {}", area);
    println!(
        "Width is {}", rectangle.width
    ); // Variable not dropped.  Variable was previously moved.

    println!("Rectangle is {}", rectangle);

    println!("Area is {}", rectangle.area());
    let rectangle1 = Rectangle1 { width: 30_u32, height: 50 };
    println!("Area is rectangle1 {}", rectangle1.area());
}

fn sum_three(a: u32, b: u32, c: u32) -> u32 {
    a + b + c
}

fn min(a: u32, b: u32) -> u32 {
    if a < b {
        a
    } else {
        b
    }
}

fn min2(a: u32, b: u32, c: u32) -> u32 {
    if (a <= b) & (a <= c) {
        a
    } else if (b <= a) & (b <= c) {
        b
    } else {
        c
    }
}

fn fib(mut a: felt252, mut b: felt252, mut n: felt252) -> felt252 {
    loop {
        if n == 0 {
            break a;
        }
        n -= 1;
        let temp = b;
        b = a + b;
        a = temp;
    }
}

fn sum_array(mut arr: Array<u32>) -> u32 {
    let mut sum = 0_u32;

    loop {
        match arr.pop_front() {
            Option::Some(current_value) => { sum += current_value },
            Option::None => { break; },
        }
    };
    sum
}

// fn return_len(arr: Array<u32>) -> u32 {
// fn return_len(arr: @Array<u32>) -> u32 {
fn return_len(arr: Span<u32>) -> u32 {
    arr.len()
}

fn sum_array2(mut arr: Span<u32>) -> u32 {
    let mut sum: u32 = 0;

    loop {
        match arr.pop_front() {
            Option::Some(current_value) => { sum += *current_value },
            Option::None => { break; },
        }
    };
    sum
}

fn sum_array3(ref arr: Array<u32>) -> u32 {
    let mut sum: u32 = 0;

    loop {
        match arr.pop_front() {
            Option::Some(current_value) => { sum += current_value },
            Option::None => { break; },
        }
    };
    sum
}

fn area(rectangle: @Rectangle) -> u64 {
    *rectangle.width * *rectangle.height
}

impl RectangleDisplay of core::fmt::Display<Rectangle> {
    fn fmt(self: @Rectangle, ref f: core::fmt::Formatter) -> Result<(), core::fmt::Error> {
        write!(f, "width: ")?;
        core::fmt::Display::fmt(self.width, ref f)?;
        write!(f, ", height: ")?;
        core::fmt::Display::fmt(self.height, ref f)
    }
}

impl RectangleImpl of RectangleTrait {
    fn area(self: @Rectangle) -> u64 {
        *self.width * *self.height
    }
}

#[cfg(test)]
mod tests {
    use super::sum_three;

    #[test]
    fn it_works() {
        assert(sum_three(1, 2, 3) == 6, 'Sum Fail');
        assert_eq!(sum_three(1, 2, 3), 6);
        assert_eq!(sum_three(10, 20, 30), 60);
    }
}
// 当我们使用简单类型 （u8 u16 u32） 时， 不需要关注所有权类型，只有报错的时候才关注
// 当遇到所有权的时候，不想改变则使用 @ Span 快照类型  修改则使用 ref 要求是可变的变量 使用 mut 


