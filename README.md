# extractROIandDoseMap

A Python-based tool for extracting Regions of Interest (ROI) from medical images and generating corresponding dose maps for radiotherapy planning and analysis.

## Overview

**extractROIandDoseMap** streamlines the workflow of segmenting anatomical structures from medical imaging data and visualizing radiation dose distributions. This tool is designed for medical physicists, radiation oncologists, and researchers working in radiotherapy treatment planning and dose verification.

## Features

- **ROI Extraction**: Automatically or manually segment regions of interest from medical images (CT, MRI, PET)
- **Dose Map Generation**: Create and visualize 2D and 3D dose distribution maps
- **Dose Analysis**: Calculate dosimetric metrics (mean dose, max dose, dose-volume histograms)
- **Image Processing**: Built-in support for common medical imaging formats (DICOM)
- **Visualization**: Generate publication-quality dose maps and ROI overlays
- **Batch Processing**: Process multiple patient datasets efficiently

## Installation

### Requirements
- Python 3.8+
- NumPy
- PyDICOM (for DICOM file handling)
- Matplotlib
- SimpleITK or similar medical imaging library

### Setup

```bash
git clone https://github.com/farahzadieng/extractROIandDoseMap.git
cd extractROIandDoseMap
pip install -r requirements.txt
```

## Quick Start

```python
from extractROIandDoseMap import ROIExtractor, DoseMapper

# Load medical image
roi_extractor = ROIExtractor('path/to/dicom/image.dcm')

# Extract ROI
roi_data = roi_extractor.extract_roi(roi_name='GTV')

# Generate dose map
dose_mapper = DoseMapper('path/to/dose/file.dcm')
dose_map = dose_mapper.generate_dose_map(roi_data)

# Visualize
dose_map.plot()
dose_map.save('output/dose_map.png')
```

## Usage

### Extracting ROIs

```python
# Extract single ROI
roi = roi_extractor.extract_roi(roi_name='PTV')

# Extract multiple ROIs
rois = roi_extractor.extract_multiple_rois(['GTV', 'PTV', 'OAR1'])

# Get ROI statistics
volume = roi.get_volume()
centroid = roi.get_centroid()
```

### Generating Dose Maps

```python
# Create dose map with custom settings
dose_map = dose_mapper.generate_dose_map(
    roi_data=roi,
    colormap='jet',
    dose_range=(0, 80),  # Gy
    interpolation='linear'
)

# Calculate dose-volume histogram (DVH)
dvh = dose_map.calculate_dvh()
dvh.plot()
```

### Dosimetric Analysis

```python
# Extract metrics
mean_dose = dose_map.get_mean_dose(roi)
max_dose = dose_map.get_max_dose(roi)
volume_above_threshold = dose_map.get_volume_at_dose(roi, dose_threshold=50)

# Generate report
report = dose_map.generate_report()
report.save_to_pdf('output/dosimetry_report.pdf')
```

## File Structure

```
extractROIandDoseMap/
├── README.md
├── requirements.txt
├── extractROIandDoseMap/
│   ├── __init__.py
│   ├── roi_extractor.py
│   ├── dose_mapper.py
│   ├── utils.py
│   └── visualization.py
├── examples/
│   ├── basic_usage.py
│   └── batch_processing.py
└── tests/
    └── test_*.py
```

## Supported Formats

- **Medical Images**: DICOM (.dcm), NIfTI (.nii, .nii.gz)
- **Dose Files**: DICOM Dose (.dcm), ASCII dose matrices
- **Output**: PNG, PDF, DICOM, VTK (3D visualization)

## Documentation

For detailed documentation and API reference, see the [docs/](docs/) folder or visit the [wiki](https://github.com/farahzadieng/extractROIandDoseMap/wiki).

## Examples

See the [examples/](examples/) directory for complete working examples including:
- Basic ROI extraction and dose mapping
- Batch processing multiple patients
- DVH analysis and comparison
- Creating custom visualizations

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

```

## Disclaimer

This tool is intended for research and educational purposes. For clinical use in radiotherapy, validation against certified treatment planning systems is required.

## Contact

For questions, issues, or suggestions, please open an [issue](https://github.com/farahzadieng/extractROIandDoseMap/issues) or contact the maintainer at farahzadieng@example.com.

---

**Last Updated**: September 2026
