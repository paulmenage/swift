// RUN: %target-swift-frontend %s -emit-ir -g -o - | FileCheck %s

// CHECK: @_TFC12generic_arg25Class3foo{{.*}}, %swift.type* %U
// CHECK: %[[Y:.*]] = call %swift.opaque* %allocateBuffer3([{{(24|12)}} x i8]* %{{.*}}, %swift.type* %U)
// store %swift.opaque* %[[Y]], %swift.opaque** %[[Y_SHADOW:.*]], align
// CHECK: call void @llvm.dbg.value(metadata %swift.opaque* %[[Y]], {{.*}}metadata ![[U:.*]], metadata !{{[0-9]+}}), !dbg
// Make sure there is no conflicting dbg.value for this variable.x
// CHECK-NOT: dbg.value{{.*}}metadata ![[U]]
class Class <T> {
// CHECK: ![[U]] ={{.*}} [ DW_TAG_arg_variable ] [y] [line [[@LINE+1]]]
	func foo <U> (var x : T, var y : U)
	{
		println("hello world")
	}

	func bar (var x : String, var y : Int) {
		println("hello world")
	}

	init() {}
}

func main() {
	var object : Class<String> = Class()
	var x = "hello"
	var y = 1234
	object.bar(x, y: y)
	object.foo(x, y: y)
}

main()
