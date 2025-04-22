```c++
int func(&x){
	x += 10;
}

int main(){
	int x = 5;
	int z;
	z = x + func(x);
	cout << z;
}
```

![[Pasted image 20250415144247.png]]