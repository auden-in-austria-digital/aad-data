import subprocess

def update_notebook():
    notebook_path = './metadata/ipynb/output_doc_id.ipynb'

    try:
        # Run the Jupyter notebook in place, re-running all cells
        subprocess.run(
            ['jupyter', 'nbconvert', '--to', 'notebook', '--inplace', '--execute', notebook_path],
            check=True
        )
        print(f"Notebook '{notebook_path}' has been successfully updated.")
    except subprocess.CalledProcessError as e:
        print(f"Error: Failed to update the notebook. {e}")
    except Exception as e:
        print(f"Unexpected error occurred: {e}")

if __name__ == "__main__":
    update_notebook()
