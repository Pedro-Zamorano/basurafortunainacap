// 

package zl.apirest.backend.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "request_history")
public class RequestHistory extends PkEntityBase {

    @Column(name = "description", nullable = false)
    private String description;

    @Column(name = "origin", nullable = false)
    private String origin;

    @Column(name = "attach_picture", nullable = false)
    private String picture;

    @ManyToOne
    @JoinColumn(name = "recycling_request_fk", referencedColumnName = "id", nullable = false)
    private RecyclingRequest recyclingRequest;

}
