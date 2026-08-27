# 用于流水线测试

从脚本中可以看到，PR title需要遵循Conventional Commits规范：
- 格式：`<type>(<scope>): <description>`
- 允许的类型：feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert|merge
- 示例：
- feat: add new feature
- fix(auth): fix login bug
- docs: update README



curl http://127.0.0.1:8008/v1/chat/completions \
-H "Content-Type: application/json" \
-X POST \
-d '{
"model": "Qwen3-0.6B",
"temperature": 0,
"messages": [
{"role": "system", "content": "You are a helpful assistant."},
{"role": "user", "content": "你是谁"}
]
}'
