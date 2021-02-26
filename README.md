# WootElixir

Elixir demo application. Used for an internal tech talk as an intro to Elixir (and why we use it in our team).

Run it:

- `mix deps.get`
- `iex -S mix`

## Demo 1

Show: Code organization (modules, functions), documentation, doc tests, pattern matching.

- maths.ex: modules, functions, documentation, doc test, pattern matching
- maths_text.exs: unit tests
- router.ex, maths_router.ex: pipeline operator, "let it crash", pattern matching

curl localhost:1337/hello
curl localhost:1337/bla

mix test

iex -S mix
curl localhost:1337/maths/div/10/2
curl localhost:1337/maths/div/2/0

curl localhost:1337/maths/fib/3
curl localhost:1337/maths/fib/6

## Demo 2; Responsiveness

Wonders of the BEAM. Frequent context switches.

Show: Processes, :observer.start

```elixir
:erlang.system_info(:logical_processors) # schedulers
:observer.start
```

```bash
curl localhost:1337/maths/fib/40
curl localhost:1337/maths/fib/45 & curl localhost:1337/maths/fib/45 & curl localhost:1337/maths/fib/45 & curl localhost:1337/maths/fib/45 & curl localhost:1337/maths/fib/45 & curl localhost:1337/maths/fib/45 & curl localhost:1337/maths/fib/45 & curl localhost:1337/maths/fib/45 & curl localhost:1337/maths/fib/45 (44s)
curl localhost:1337/maths/fib/25
curl localhost:1337/maths/div/2/0
curl localhost:1337/maths/div/1000/4
```

## Demo 3; Supervision

Show: supervision tree in code, and observer

docker-compose up -d

## Demo 3.5; Distribution and observability

Show: Connect 2 nodes, rpc calls, list processes (for debugging), supervision

Connect two nodes:

```bash
iex --sname prod -S mix
PORT=1338 iex --sname debug -S mix
```

```elixir
prod = :'prod@JoelC-work'
Node.connect(prod)
:rpc.call(prod, Process, :list, [])
```

Trigger bug taking up CPU:

curl localhost:1337/maths/fib/-1

Find out the problem from remote node:

prod |> :rpc.call(Process, :list, []) |> Enum.map(&{:rpc.call(prod, Process, :info, [&1, :reductions]), &1}) |> Enum.reject(fn {f, _} -> f == nil end) |> Enum.sort(fn {{_, a}, _pid}, {{_, b}, _pid2} -> a >= b end) |> Enum.take(5)
pid = pid()
:rpc.call(prod, Process, :info, [pid, :current_stacktrace])

Brutally kill the process:

:rpc.call(prod, Process, :exit, [pid, :kill])

---

## Other demo ideas

- i think a simple web app using phoenix, showing how pattern matching work maybe. some good introduction to functional programming. and maybe add some rabbitmq consumer or publisher or your processes examples. like HTTP Post -> rabbit publisher
- Nerves might also be worth a mention
- Build a chatroom in 100 lines: https://gist.github.com/josevalim/2783092
- I would just start million processes on your machine :D
