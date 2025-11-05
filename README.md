### One time setup
Clone the repository
```
cd ~/phd
rm -rf joined-transceiver-optimization
git clone https://github.com/rahuljeyaraj/joined-transceiver-optimization.git
cd joined-transceiver-optimization
chmod +x *.sh
```

Fresh Conda installation
```
./setup_conda.sh
```

Fresh environment creation
```
./create_env.sh
```

### Execution
Run model training
```
./run_model.sh
```

Run testing
```
./run_test.sh
```
