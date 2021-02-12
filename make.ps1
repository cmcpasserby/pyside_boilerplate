#requires -Version 3

param(
    $Command
)

switch ($Command) {
    clean {
        Remove-Item build -Recurse -ErrorAction Ignore
        Remove-Item dist -Recurse -ErrorAction Ignore
        Remove-Item venv\pyinstaller -Recurse -ErrorAction Ignore
    }

    devenv {
        virtualenv --clear --python=python3.9.1 venv/dev
        venv\dev\Scripts\activate.ps1
        pip install -r requirements\app.txt
        deactivate
        Write-Host "dev virtualenv made at venv/dev ('source venv/dev/bin/activate' to activate)"
    }

    pyinstaller {
        virtualenv --clear --python=python3.9.1 venv\pyinstaller
        venv\pyinstaller\Scripts\activate.ps1
        pip install -r requirements\pyinstaller.txt
        pip install -r requirements\app.txt
        pyinstaller -y misc\app.spec
        deactivate
    }
} 
