export interface Post {
    _id: string;
    title: string;
    content: string;
    author: string;
    createdAt: string;
    updatedAt?: string;
}
export declare const getPosts: () => Promise<import("axios").AxiosResponse<{
    data: Post[];
}, any, {}>>;
export declare const createPost: (data: {
    title: string;
    content: string;
    author: string;
}) => Promise<import("axios").AxiosResponse<{
    data: Post;
}, any, {}>>;
export declare const updatePost: (id: string, data: any) => Promise<import("axios").AxiosResponse<any, any, {}>>;
export declare const deletePost: (id: string) => Promise<import("axios").AxiosResponse<any, any, {}>>;
//# sourceMappingURL=posts.d.ts.map