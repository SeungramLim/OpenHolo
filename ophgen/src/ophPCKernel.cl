
extern const char *pKernel[] =
{
"typedef struct cl_complex\n"
"{\n"
"	double real;\n"
"	double imag;\n"
"} Complex;\n"
"\n"
"\n"
"typedef struct KernelConst_NotEncodedRS\n"
"{\n"
"	int n_points;	/// number of point cloud\n"
"	int n_colors;	/// number of colors per point cloud\n"
"	int n_streams;	/// number of streams\n"
"\n"
"	double scale_X;		/// Scaling factor of x coordinate of point cloud\n"
"	double scale_Y;		/// Scaling factor of y coordinate of point cloud\n"
"	double scale_Z;		/// Scaling factor of z coordinate of point cloud\n"
"\n"
"	double offset_depth;	/// Offset value of point cloud in z direction\n"
"\n"
"	int pn_X;		/// Number of pixel of SLM in x direction\n"
"	int pn_Y;		/// Number of pixel of SLM in y direction\n"
"\n"
"	double pp_X; /// Pixel pitch of SLM in x direction\n"
"	double pp_Y; /// Pixel pitch of SLM in y direction\n"
"\n"
"	double half_ss_X; /// (pixel_x * nx) / 2\n"
"	double half_ss_Y; /// (pixel_y * ny) / 2\n"
"\n"
"	double k;		  /// Wave Number = (2 * PI) / lambda;\n"
"	double lambda;	/// Wave Length\n"
"\n"
"	double det_tx;  /// tx / sqrt(1 - tx^2), tx = lambda / (2 * pp_X)\n"
"	double det_ty;  /// ty / sqrt(1 - ty^2), ty = lambda / (2 * pp_Y)\n"
"} KernelConfig;\n"
"\n"
"\n"
"__kernel void clKernel_diffractNotEncodedRS(\n"
"	__global Complex *output, \n"
"	__global double *a, \n"
"	__global double *b, \n"
"	__global KernelConfig *config, \n"
"	const unsigned int cnt) \n"
"{\n"
"	uint width = get_global_size(0); \n"
"	uint row = get_global_id(1); \n"
"	uint col = get_global_id(0); \n"
"	uint idx = width * row + col; \n"
"	if(idx < cnt) { \n"
"		double xxx = -config->half_ss_X + (col - 1) * config->pp_X; \n"
"		double yyy = -config->half_ss_Y + (config->pn_Y - row) * config->pp_Y; \n"
"		double pcx = a[3 * 0 + 0] * config->scale_X; \n"
"		double pcy = a[3 * 0 + 1] * config->scale_Y; \n"
"		output[idx].real = a[idx]; \n"
"		output[idx].imag = b[idx]; \n"
"	} \n"
"}\n"
};
