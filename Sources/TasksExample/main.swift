
import Tasks

print("Starting echo")
let res = try! Task.run("echo", "yolo")
print("Result: \(res)")
print("Finished echo")
