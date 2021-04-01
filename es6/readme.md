# ES6
---

### 역사
- 자바스크립트는 1990년대 Netscape 회사에서 Brendan Eich라는 사람에 의해 최초 개발되었습니다. 이후 MS에서 IE 브라우저에 Jscript라는 언어를 탑재하면서 표준을 필요로 하기 시작했습니다.

- 해당 표준을 `EcmaScript` 라고 하고 javascript는 이 표준에 따라 발전해왔습니다. EcmaScript를 줄여서 `ES` 라고 하며 ES의 버전은 계속 업데이트되고 있습니다. (현재 ES11)

- Javascript의 ES 버전은 꾸준히 올라가지만, 그렇다고 우리가 최신 버전의 문법을 꼭 알아야 할 필요는 없어요. 왜냐하면 javascript를 이용한 개발 환경(각 브라우저들, React, Node.js 등)에 따라 채택한 ES 버전이 조금씩 다르기 때문이에요.


### 기본 문법
- 가장 대중적인 Javascript 문법

- 변수 
  - ```let``` : 변수 재선언 가능
  - ```const``` : 변수 재선언 불가능, 재할당 불가능
- 비동기 처리 
  - ```Promise``` 
```
axios.get(`URL`)
.then((result)=>{
//처리
}).catch((error)=>{
//예외
})
```
- Template Literal
  - String 자료형 조합을 더 쉽고, 가독성 좋게 해주는 문법
  
```
const hello = '안녕?';
const text = `hello $(hello) world';
```

- Destructuring 
  - 변수를 받았을때 아래와 같이 사용하면 변수에 담아진다.
```
const {id, name, path} = params;
```
  
- map, foreach
  - 배열을 조회(loop)
  - map 은 return 이 있다.

```
//첫번째 파라미터에는 값, 두번째 파라미터에는 순서(index)가 들어간다.
customers.forEach(function (customer, index) { 
         console.log((index + 1) + '번째 호출');
         console.log(customer);
})

//동일하게 조회합니다.
customers.map(function(customer, index){ 
         console.log((index + 1) + '번째 호출');
         console.log(customer);
});

//customerNames는 각 customer name이 들어간 배열이다
var customerNames = prodcustomersucts.map((customer, index) => { 
     return customer.name;
});

//React에서는 다음과 같은 방식으로 데이터가 담긴 배열을 화면에 표시합니다.
var customerElements = customers.map((customer,index) =>{ 
	return (
		<div>
			<span>{customer.name}</span>
			...
		</div>
	)
})
```

- Lamda
  - 함수 선언 방식
```
const func = () => {}
```

- 3항 연산자
```
const language === 'javascript' ? true : false
```

- export, import
  - 모듈 불러오는 방식 
```
import axios from 'axios'; //다운받은 axios 라이브러리를 불러옵니다. 
import App from './App.js' //hello.js 파일을 불러옵니다.
import Potato from "./main" //import를 할때 모듈명은 자유롭게 설정이 가능합니다.


function funcA(){
	//...
}
function funcB(){
	//...
}
const varC = 'hello';
export {
		a : funcA,
	b : funcB,
	c : varC
}

import {a, b, c} from './App.js'
```