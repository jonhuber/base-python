build-container-dev:
    podman build --target dev -t basepy:dev .

build-container-image:
    podman build --ssh default --target app -t basepy:latest .

build-latest: build-container-image

[no-exit-message]
run cmd="":
    podman run -i -t localhost/basepy:latest {{ cmd }}
